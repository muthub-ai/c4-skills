# Standardized Test Prompts

These prompts can be used to manually test the behavior of the `c4designer` skill across different AI agents (e.g., Claude, Copilot, Antigravity) using the provided `example-codebase`.

## Test 1: Document-Code (Container Level)

**Context:** Testing the ability of the agent to scan a codebase and generate a Level 2 Container Diagram.

**Prompt:**
> "Act as the C4 Designer. I have an example codebase located in `tests/example-codebase`. Please retro-document this system. I want to see a Level 2 Container Diagram for this system. Output it as a Markdown file with embedded Mermaid."

**Expected Result:**
- Agent detects the mode as `Document-code`.
- Agent analyzes `docker-compose.yml`, `frontend/src/App.jsx`, and `api/src/index.js`.
- Agent generates a markdown file (e.g., `02-container.md`) containing a `C4Container` diagram.
- Diagram should identify the Single-Page App (React), API Application (Express), and Database (Postgres).
- Diagram should identify external systems (E-mail System via SMTP).

## Test 2: Document-Code (Component Level)

**Context:** Testing the ability to zoom into a specific container and extract its components.

**Prompt:**
> "Act as the C4 Designer. For the API Application in `tests/example-codebase/api`, please create a Level 3 Component diagram."

**Expected Result:**
- Agent detects mode as `Document-code` or continues the context.
- Agent analyzes `api/src/index.js` and `api/src/services/AccountService.js`.
- Agent identifies components like `AccountService`.
- Relationships correctly point to the Database via JDBC/pg.

## Test 3: adr-scribe (Interview Mode)

**Context:** Testing the ability to interview a user and draft an ADR.

**Prompt:**
> "Act as the adr-scribe. We just decided to switch from MongoDB to PostgreSQL for our new API. Please interview me to draft a new Architecture Decision Record."

**Expected Result:**
- Agent detects mode as `Interview`.
- Agent asks maximum 3 questions about the context, decision, and consequences.
- Agent drafts a MADR format document.

## Test 4: adr-scribe (Retro-Document Mode)

**Context:** Testing the ability to infer an architectural decision from prose.

**Prompt:**
> "Act as the adr-scribe. We're building the new Internet Banking API. We chose PostgreSQL because it offers strict ACID compliance, even though schema migrations will be harder than MongoDB. Please retro-document this decision."

**Expected Result:**
- Agent detects mode as `Retro-Document`.
- Agent outputs a well-formatted MADR document.
- Positive consequences correctly include ACID compliance.
- Negative consequences correctly include harder migrations.
