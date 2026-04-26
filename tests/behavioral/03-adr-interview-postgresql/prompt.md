# Prompt: ADR Interview — PostgreSQL Decision

> **Skill:** `adr-scribe`  
> **Mode:** `Interview`

Give this prompt verbatim to the agent after installing the `adr-scribe` skill:

---

Act as the adr-scribe. We just decided to switch from MongoDB to PostgreSQL for our new Internet Banking API. Please interview me to draft a new Architecture Decision Record.

---

## Acceptance Criteria

The agent's behavior MUST:
- [ ] Auto-detect the mode as `Interview` (not ask for mode confirmation)
- [ ] Ask a **maximum of 3 questions per batch**
- [ ] Ask about: context, alternatives considered, and consequences (positive AND negative)
- [ ] Draft a MADR-format document before writing any file
- [ ] Ask for validation before writing the final file
- [ ] Prompt the user about updating C4 diagrams after completing the ADR
