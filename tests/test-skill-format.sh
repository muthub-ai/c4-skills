#!/bin/bash
set -e

echo "Running Skills Validation Tests..."

# Find all skill directories containing SKILL.md
for SKILL_FILE in ../*/SKILL.md; do
    SKILL_DIR=$(dirname "$SKILL_FILE")
    SKILL_NAME=$(basename "$SKILL_DIR")
    
    echo "-----------------------------------"
    echo "Testing Skill: $SKILL_NAME"
    echo "-----------------------------------"

    if [ ! -f "$SKILL_FILE" ]; then
        echo "❌ SKILL.md not found in $SKILL_DIR"
        exit 1
    fi
    echo "✅ SKILL.md exists"

    # Test YAML frontmatter
    if head -n 1 "$SKILL_FILE" | grep -q "^---$"; then
        echo "✅ YAML frontmatter starts correctly"
    else
        echo "❌ YAML frontmatter missing starting '---'"
        exit 1
    fi

    if grep -q "^name:" "$SKILL_FILE" && grep -q "^description:" "$SKILL_FILE"; then
        echo "✅ YAML frontmatter contains name and description"
    else
        echo "❌ YAML frontmatter missing name or description"
        exit 1
    fi

    # Optional: Run diagram tests if examples exist
    if [ -d "$SKILL_DIR/examples" ] && [ "$SKILL_NAME" = "c4designer" ]; then
        echo "Testing C4 Diagram Validation against examples for $SKILL_NAME..."
        for example in "$SKILL_DIR"/examples/*.md; do
            if [ -f "$example" ]; then
                ./validate-c4-diagram.sh "$example"
            fi
        done
    fi
done

# Validate the generated examples from the sandbox example-codebase
if [ -d "example-codebase/diagrams" ]; then
    echo "-----------------------------------"
    echo "Testing Generated Sandbox Diagrams"
    echo "-----------------------------------"
    for example in example-codebase/diagrams/*.md; do
        if [ -f "$example" ]; then
            ./validate-c4-diagram.sh "$example"
        fi
    done
fi

echo "🎉 All tests passed successfully!"
exit 0
