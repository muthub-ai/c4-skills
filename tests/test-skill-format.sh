#!/bin/bash
# =============================================================================
# c4-skills Test Suite
# =============================================================================
# Validates the structural integrity, YAML frontmatter compliance, and
# domain-specific syntax of all skills and generated artifacts in this repo.
#
# Usage: ./test-skill-format.sh
# Exit codes: 0 = all tests passed, 1 = one or more tests failed
# =============================================================================

set -e

# --- Formatting helpers -------------------------------------------------------
BOLD="\033[1m"
DIM="\033[2m"
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m"
RESET="\033[0m"

PASS="  ${GREEN}✔${RESET}"
FAIL="  ${RED}✘${RESET}"
INFO="  ${CYAN}→${RESET}"

PASS_COUNT=0
FAIL_COUNT=0
SUITE_START=$(date +%s)

# --- Utility: pass/fail counters ----------------------------------------------
pass() { echo -e "$PASS $1"; PASS_COUNT=$((PASS_COUNT + 1)); }
fail() { echo -e "$FAIL $1"; FAIL_COUNT=$((FAIL_COUNT + 1)); }
info() { echo -e "$INFO ${DIM}$1${RESET}"; }
section() {
    echo ""
    echo -e "${BOLD}${CYAN}══ $1 ══${RESET}"
}

# --- Suite header -------------------------------------------------------------
echo ""
FRAMEWORK_VERSION=$(grep "^version:" ../c4designer/SKILL.md | head -1 | cut -d' ' -f2- | tr -d '"')
echo -e "${BOLD}╔══════════════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}║         c4-skills Test Suite v${FRAMEWORK_VERSION}                ║${RESET}"
echo -e "${BOLD}╚══════════════════════════════════════════════════╝${RESET}"
echo -e "  ${DIM}Running all structural, compliance, and domain checks...${RESET}"
echo ""

# =============================================================================
# SUITE 1: Skill Structural Validation
# =============================================================================
section "SUITE 1: Skill YAML Frontmatter & Structure"

for SKILL_FILE in ../*/SKILL.md; do
    SKILL_DIR=$(dirname "$SKILL_FILE")
    SKILL_NAME=$(basename "$SKILL_DIR")

    echo ""
    echo -e "  ${BOLD}Skill: $SKILL_NAME${RESET}"
    info "Source: $SKILL_FILE"

    # Test 1.1 — SKILL.md exists
    if [ -f "$SKILL_FILE" ]; then
        pass "[1.1] SKILL.md exists"
    else
        fail "[1.1] SKILL.md not found at $SKILL_FILE"
        exit 1
    fi

    # Test 1.2 — YAML frontmatter starts with ---
    if head -n 1 "$SKILL_FILE" | grep -q "^---$"; then
        pass "[1.2] YAML frontmatter opens correctly (---)"
    else
        fail "[1.2] YAML frontmatter missing opening '---'"
        exit 1
    fi

    # Test 1.3 — Required fields: name, description
    if grep -q "^name:" "$SKILL_FILE" && grep -q "^description:" "$SKILL_FILE"; then
        NAME=$(grep "^name:" "$SKILL_FILE" | head -1 | cut -d' ' -f2-)
        pass "[1.3] Required fields present (name: $NAME, description)"
    else
        fail "[1.3] YAML missing required 'name' or 'description' field"
        exit 1
    fi

    # Test 1.4 — Version field
    if grep -q "^version:" "$SKILL_FILE"; then
        VERSION=$(grep "^version:" "$SKILL_FILE" | head -1 | cut -d' ' -f2-)
        pass "[1.4] Version declared (version: $VERSION)"
    else
        fail "[1.4] YAML missing 'version' field — required for enterprise tracking"
        exit 1
    fi

    # Test 1.5 — Enterprise compatibility metadata
    if grep -q "^requires:" "$SKILL_FILE" && grep -q "^compatible_agents:" "$SKILL_FILE"; then
        pass "[1.5] Enterprise compatibility metadata present (requires, compatible_agents)"
    else
        fail "[1.5] YAML missing 'requires' or 'compatible_agents' — required for enterprise adoption"
        exit 1
    fi

    # Test 1.6 — C4 diagram validation for c4designer examples
    if [ -d "$SKILL_DIR/examples" ] && [ "$SKILL_NAME" = "c4designer" ]; then
        echo ""
        info "Running C4 syntax validation on examples..."
        for example in "$SKILL_DIR"/examples/*.md; do
            if [ -f "$example" ]; then
                base=$(basename "$example")
                if OUTPUT=$(./validate-c4-diagram.sh "$example" 2>&1); then
                    pass "[1.6] Example '$base' is a valid C4 diagram"
                else
                    fail "[1.6] Example '$base' failed C4 validation:\n$OUTPUT"
                fi
            fi
        done
    fi

    # Test 1.7 — ADR validation for adr-scribe examples
    if [ -d "$SKILL_DIR/examples" ] && [ "$SKILL_NAME" = "adr-scribe" ]; then
        echo ""
        info "Running ADR completeness validation on examples..."
        for example in "$SKILL_DIR"/examples/*.md; do
            if [ -f "$example" ]; then
                base=$(basename "$example")
                if OUTPUT=$(./validate-adr.sh "$example" 2>&1); then
                    pass "[1.7] Example '$base' is a valid ADR"
                else
                    fail "[1.7] Example '$base' failed ADR validation:\n$OUTPUT"
                fi
            fi
        done
    fi
done

# =============================================================================
# SUITE 2: Sandbox Diagram Validation
# =============================================================================
section "SUITE 2: Sandbox Golden Diagram Validation"

if [ -d "example-codebase/diagrams" ]; then
    echo ""
    info "Validating golden C4 diagrams in example-codebase/diagrams..."
    for example in example-codebase/diagrams/*.md; do
        if [ -f "$example" ]; then
            base=$(basename "$example")
            if OUTPUT=$(./validate-c4-diagram.sh "$example" 2>&1); then
                pass "[2.1] Golden diagram '$base' is valid"
            else
                fail "[2.1] Golden diagram '$base' failed validation:\n$OUTPUT"
            fi
        fi
    done
else
    echo -e "  ${YELLOW}⚠  No sandbox diagrams found — skipping Suite 2${RESET}"
fi

# =============================================================================
# SUITE 3: Behavioral Fixture Validation
# =============================================================================
section "SUITE 3: Behavioral Fixture Validation"

BEHAVIORAL_DIR="behavioral"
if [ -d "$BEHAVIORAL_DIR" ]; then
    echo ""
    info "Running behavioral fixture checks..."
    FIXTURE_COUNT=0
    FIXTURE_PASS=0
    for fixture_dir in "$BEHAVIORAL_DIR"/*/; do
        if [ -d "$fixture_dir" ]; then
            FIXTURE_COUNT=$((FIXTURE_COUNT + 1))
            fixture_name=$(basename "$fixture_dir")
            # Completeness check: must have a prompt.md with '## Acceptance Criteria'
            prompt="$fixture_dir/prompt.md"
            if [ ! -f "$prompt" ] || ! grep -q "^## Acceptance Criteria" "$prompt"; then
                fail "[3.$FIXTURE_COUNT] Behavioral fixture '$fixture_name': missing prompt.md or '## Acceptance Criteria' section"
            else
                pass "[3.$FIXTURE_COUNT] Behavioral fixture '$fixture_name': prompt completeness"
            fi
            
            expected="$fixture_dir/expected.md"
            if [ -f "$expected" ]; then
                # Route to the right validator using skill.txt in the fixture dir
                FIXTURE_SKILL="c4designer"
                if [ -f "$fixture_dir/skill.txt" ]; then
                    FIXTURE_SKILL=$(cat "$fixture_dir/skill.txt" | tr -d '[:space:]')
                fi
                if [ "$FIXTURE_SKILL" = "adr-scribe" ]; then
                    VALIDATOR="./validate-adr.sh"
                else
                    VALIDATOR="./validate-c4-diagram.sh"
                fi
                
                # Check for negative tests
                if [[ "$fixture_name" == negative-* ]]; then
                    if OUTPUT=$($VALIDATOR "$expected" 2>&1); then
                        fail "[3.$FIXTURE_COUNT] Behavioral fixture '$fixture_name': expected output should have FAILED validation but passed."
                    else
                        pass "[3.$FIXTURE_COUNT] Behavioral fixture '$fixture_name': expected output correctly failed validation."
                    fi
                else
                    if OUTPUT=$($VALIDATOR "$expected" 2>&1); then
                        pass "[3.$FIXTURE_COUNT] Behavioral fixture '$fixture_name': expected output is valid"
                    else
                        fail "[3.$FIXTURE_COUNT] Behavioral fixture '$fixture_name': expected output failed validation:\n$OUTPUT"
                    fi
                fi
                FIXTURE_PASS=$((FIXTURE_PASS + 1))
            else
                fail "[3.$FIXTURE_COUNT] Behavioral fixture '$fixture_name': missing expected.md"
            fi
        fi
    done
    if [ "$FIXTURE_COUNT" -eq 0 ]; then
        echo -e "  ${YELLOW}⚠  No behavioral fixtures found in $BEHAVIORAL_DIR/${RESET}"
    fi
else
    echo -e "  ${YELLOW}⚠  Behavioral test directory not found — skipping Suite 3${RESET}"
fi

# =============================================================================
# SUITE 4: Registry Completeness
# =============================================================================
section "SUITE 4: Registry Completeness"

REGISTRY="../registry.json"
echo ""
if [ ! -f "$REGISTRY" ]; then
    fail "[4.1] registry.json not found at root — required for machine-readable skill discovery"
else
    pass "[4.1] registry.json exists"
    REGISTRY_COUNT=0
    for SKILL_DIR in ../*/SKILL.md; do
        SKILL_NAME=$(basename "$(dirname "$SKILL_DIR")")
        REGISTRY_COUNT=$((REGISTRY_COUNT + 1))
        if grep -q "\"id\": \"$SKILL_NAME\"" "$REGISTRY"; then
            pass "[4.$REGISTRY_COUNT] Skill '$SKILL_NAME' is registered in registry.json"
        else
            fail "[4.$REGISTRY_COUNT] Skill '$SKILL_NAME' is NOT in registry.json — update registry.json when adding a skill"
        fi
    done
    # Check registry version matches framework version
    REG_VERSION=$(grep '"version"' "$REGISTRY" | head -1 | sed -E 's/.*"version": "([^"]+)".*/\1/')
    SKILL_VERSION=$(grep "^version:" ../c4designer/SKILL.md | head -1 | cut -d' ' -f2-)
    if [ "$REG_VERSION" = "$SKILL_VERSION" ]; then
        pass "[4.R] registry.json version ($REG_VERSION) matches framework version ($SKILL_VERSION)"
    else
        fail "[4.R] registry.json version ($REG_VERSION) does not match framework version ($SKILL_VERSION) — keep them in sync"
    fi
fi

# =============================================================================
# Test Summary
# =============================================================================
SUITE_END=$(date +%s)
DURATION=$((SUITE_END - SUITE_START))

echo ""
echo -e "${BOLD}╔══════════════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}║                  Test Summary                    ║${RESET}"
echo -e "${BOLD}╠══════════════════════════════════════════════════╣${RESET}"
echo -e "  ${GREEN}Passed:${RESET}   $PASS_COUNT checks"
if [ "$FAIL_COUNT" -gt 0 ]; then
    echo -e "  ${RED}Failed:${RESET}   $FAIL_COUNT checks"
fi
echo -e "  ${DIM}Duration: ${DURATION}s${RESET}"
echo -e "${BOLD}╚══════════════════════════════════════════════════╝${RESET}"
echo ""

if [ "$FAIL_COUNT" -gt 0 ]; then
    echo -e "${RED}${BOLD}✘ Test suite FAILED — $FAIL_COUNT check(s) did not pass.${RESET}"
    exit 1
fi

echo -e "${GREEN}${BOLD}✔ All checks passed. The repository is in a healthy state.${RESET}"
echo ""
exit 0
