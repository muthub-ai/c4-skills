---
name: adr-scribe
version: 1.0.0
description: Interactively draft, retro-document, and review Architecture Decision Records (ADRs). The skill detects the usage mode (interview for a new decision, retro-documenting from a PR or code, or reviewing an existing ADR) and enforces the use of the Michael Nygard MADR template. This skill is meant to be used alongside c4designer to document the "why" behind the architecture. Output format is Markdown. Destination is negotiated (default local filesystem in docs/adr/).
---

# ADR Scribe — documenting architectural decisions

While C4 diagrams document *what* the architecture is, an Architecture Decision Record (ADR) documents *why* it was built that way. This skill acts as a technical scribe to help you capture important architectural decisions consistently.

## Mode detection (router)

**Always start by identifying the mode.** If it's not obvious from the user's message, ask:

> "Do you want to: (a) **interview** me to draft a new ADR, (b) **retro-document** a decision from an existing PR/codebase, or (c) **review** an existing ADR?"

### Modes

1. **Interview Mode (Greenfield/New Decision):**
   - Ask the user a series of questions (max 3 at a time) to understand the context, the options considered, and the final decision.
   - Example questions: *What is the problem we are solving? What were the alternatives? Why was this specific option chosen? What are the negative consequences?*
   - Once enough context is gathered, draft the ADR using the template.

2. **Retro-Document Mode:**
   - The user provides a link to a PR, a codebase, or a design spec.
   - Analyze the provided context to infer the Context, Decision, and Consequences.
   - Explicitly state any *Assumptions* you made, and ask the user to confirm them before finalizing the draft.

3. **Review Mode:**
   - The user pastes an existing ADR.
   - Critique it based on best practices: Is the context clear? Are the consequences balanced (both positive and negative)? Are the alternatives properly documented?

## The Template (Non-negotiable)

Every ADR must follow the structure defined in [`adr-template.md`](adr-template.md) (the Michael Nygard MADR format):
- Title
- Status (Proposed, Accepted, Deprecated, Superseded)
- Context
- Decision
- Consequences

## Common contract

### Output format
Default: **Markdown document**.

### Destination
Default: **local filesystem**, in `docs/adr/` (e.g., `docs/adr/0001-use-redis-for-caching.md`).
If an MCP is connected, you can propose saving it to Notion, Google Drive, etc. Confirm before writing.

### Dialogue rules
- **Max 3 questions per batch.** Never drown the user in a form.
- **Reformulate before assuming:** *"If I understand correctly, the main reason we chose X is Y. Is that right?"*
- **Offer options when the user hesitates:** *"Did you consider option Z? What were its drawbacks?"*
- **Incremental drafts:** Show a partial structure (e.g., just the Context) and validate as you go.
- **Explicit trade-offs.** Ensure the *Consequences* section includes both positive and negative impacts. If the user only provides positives, prompt them: *"What are the downsides or maintenance burdens of this choice?"*
- **Never deliver without validation.** Always present a draft and ask: *"Does this accurately reflect the decision?"* before writing the final file.
