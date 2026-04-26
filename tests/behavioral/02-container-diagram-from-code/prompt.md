# Prompt: Container Diagram from Code

> **Skill:** `c4designer`  
> **Mode:** `Document-Code`

Give this prompt verbatim to the agent after installing the `c4designer` skill:

---

Act as the C4 Designer. I have an existing codebase located in `tests/example-codebase`. Please retro-document this system. Scan the source code and `docker-compose.yml` and generate a Level 2 Container Diagram. Output as a Markdown file with embedded Mermaid C4.

---

## Acceptance Criteria

The agent's output MUST:
- [ ] Identify **3 containers**: Single-Page App (React), API Application (Node.js), Database (PostgreSQL)
- [ ] Identify **1 external system**: E-mail System (Microsoft Exchange / SMTP)
- [ ] Label every `Rel` with a descriptive intent (no bare "Uses")
- [ ] Include a `technology` parameter on every `Container`
- [ ] Include a `protocol` on every `Rel` between containers
- [ ] Ask for validation before writing the file
