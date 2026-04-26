---
sidebar_position: 1
---

# adr-scribe

The `adr-scribe` skill teaches your AI agent to draft, retro-document, and review Architecture Decision Records (ADRs) using the **Michael Nygard MADR template**. It is the companion to `c4designer` — if `c4designer` documents *what* the architecture is, `adr-scribe` documents *why* it was built that way.

## What is an ADR?

An Architecture Decision Record (ADR) is a short document that captures:
1. The **context** — what forces are at play
2. The **options** considered
3. The **decision** made and the rationale
4. The **consequences** — both positive and negative

The MADR format ensures every decision record is complete and balanced. A decision without documented **negative consequences** is considered incomplete by `adr-scribe`.

## Mode Detection

| Your message contains… | Mode activated |
|------------------------|---------------|
| *"we decided"*, *"should we use"*, new decision to document | [Interview](./mode-interview) |
| PR link, commit, *"retro-document"* | [Retro-Document](./mode-retro-document) |
| Existing ADR pasted + *"review this"* | [Review](./mode-review) |

## Cross-Skill Integration

After you finalize an ADR, `adr-scribe` will proactively suggest:

```
✅ ADR saved. If this decision changed the system structure, consider running:
"Act as the C4 Designer [Update mode]. Update the Container Diagram to reflect
the decision to switch from MongoDB to PostgreSQL."
```

This closes the loop: decisions are documented, and diagrams stay in sync.

## Output Format

- Default: **Markdown file** saved to `docs/adr/` (e.g., `0001-use-postgresql-over-mongodb.md`)
- Filename convention: `NNNN-short-title.md` (zero-padded, kebab-case)
- Template: Michael Nygard MADR

## MADR Template Structure

Every ADR produced by `adr-scribe` contains these sections:

```markdown
# Title

* Status: [Proposed | Accepted | Deprecated | Superseded]
* Date: YYYY-MM-DD

## Context

...

## Considered Options

* Option A
* Option B
* Option C

## Decision Outcome

Chosen option: **Option A**, because...

### Positive Consequences

* ...

### Negative Consequences

* ...
```

## Validation

Every ADR example in this repository is validated by `tests/validate-adr.sh`, which checks:
- `* Status:` field exists
- `## Context` section exists
- `## Considered Options` section exists (a decision implies alternatives were weighed)
- `## Decision Outcome` section exists
- `### Negative Consequences` section exists (every decision has trade-offs)

## Example Prompt

```
Act as the adr-scribe. We just decided to use PostgreSQL instead of MongoDB
for our new payments API because we need ACID transactions. Please interview
me to draft a new Architecture Decision Record.
```
