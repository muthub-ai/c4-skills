---
sidebar_position: 2
---

# Validator Errors

Every error message that `tests/validate-c4-diagram.sh` and `tests/validate-adr.sh` can emit, with the exact cause and fix.

---

## C4 Diagram Validator (`validate-c4-diagram.sh`)

### `❌ Missing \`\`\`mermaid code block`
The Markdown file does not contain a fenced ` ```mermaid ` block.

**Fix:** Wrap your diagram in a Mermaid code fence:
````
```mermaid
C4Container
    ...
```
````

### `❌ Missing C4 graph type declaration`
The mermaid block does not start with a valid C4 keyword.

**Valid keywords:** `C4Context`, `C4Container`, `C4Component`, `C4Dynamic`, `C4Deployment`

**Fix:** The first line inside the mermaid block must be the graph type:
```
C4Container
    title ...
```

### `❌ Missing title declaration in diagram`
The mermaid block does not contain a `title ` statement.

**Fix:** Add a title as the second line of the diagram:
```
C4Container
    title Container Diagram for My System
```

### `❌ Found forbidden bare intent in Rel statement`
A `Rel` label uses one of the banned generic verbs: `"Uses"`, `"Calls"`, or `"Reads"`.

**Fix:** Replace with a descriptive intent. See [Mermaid Errors → Bare intent](./mermaid-errors#-found-forbidden-bare-intent-in-rel-statement).

### `❌ Found invalid boundary syntax`
A `System()`, `Container()`, or similar element has `{` appended to it.

**Fix:** Use `System_Boundary()` or `Container_Boundary()` for grouping. See [Mermaid Errors → LBRACE error](./mermaid-errors#-parse-error-on-line-n-expecting-newline-eof-rbrace-got-lbrace).

### `❌ Found Container missing technology parameter`
A `Container`, `ContainerDb`, or `ContainerQueue` is declared with fewer than 4 parameters (alias, label, technology, description).

**Fix:** Add the technology as the 3rd parameter.

### `❌ Found Rel statement missing protocol parameter`
A `Rel` between containers has only 3 parameters (from, to, label). The 4th (protocol) is required.

**Fix:** Add the protocol as the 4th argument: `Rel(from, to, "label", "HTTPS")`.

### `❌ Found undefined alias 'X' in Rel statement`
A `Rel` references an alias that was never defined as a `Person`, `System`, `Container`, etc.

**Fix:** Define the alias before using it in `Rel`. See [Mermaid Errors → reading 'x'](./mermaid-errors#-cannot-read-properties-of-undefined-reading-x).

---

## ADR Validator (`validate-adr.sh`)

### `❌ Missing '* Status:' field in ADR`
The ADR does not have a `* Status:` line in its header.

**Fix:** Add `* Status: Accepted` (or `Proposed`, `Deprecated`, `Superseded`) to the top of the ADR.

### `❌ Missing '## Context' section in ADR`
**Fix:** Add a `## Context` section explaining the forces at play.

### `❌ Missing '## Considered Options' section in ADR`
A decision without alternatives is an announcement, not a decision record.

**Fix:** Add a `## Considered Options` section listing at least 2 alternatives.

### `❌ Missing '## Decision Outcome' section in ADR`
**Fix:** Add a `## Decision Outcome` section stating which option was chosen and why.

### `❌ Missing '### Negative Consequences' section in ADR`
Every architectural decision has trade-offs. An ADR without negative consequences is considered incomplete.

**Fix:** Add a `### Negative Consequences` subsection inside `## Decision Outcome` listing at least one trade-off.
