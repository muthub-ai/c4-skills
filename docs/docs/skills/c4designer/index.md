---
sidebar_position: 1
---

# c4designer

The `c4designer` skill teaches your AI agent to act as a C4 model expert. It implements Simon Brown's C4 model across **5 operational modes** and enforces strict architectural notation rules on every output.

## What is C4?

The C4 model ([c4model.com](https://c4model.com)) describes a software architecture through four hierarchical levels of abstraction:

| Level | Diagram | Mermaid Type | Audience |
|-------|---------|-------------|----------|
| 1 | **Context** | `C4Context` | Everyone |
| 2 | **Container** | `C4Container` | Technical team |
| 3 | **Component** | `C4Component` | Developers |
| 4 | **Code** | `classDiagram` | Developers |

> **Simon Brown's golden rule**: *"Context + Container diagrams are sufficient for most software development teams."* Only produce levels 3 and 4 when explicitly needed.

## Mode Detection

The agent automatically detects which mode to use based on your message:

| Your message contains… | Mode activated |
|------------------------|---------------|
| *"design"*, *"new system"*, vague idea | [Design](./mode-design) |
| Code snippet, repo path, *"my codebase"* | [Document-Code](./mode-document-code) |
| README, spec, ADR, prose pasted | [Document-Prose](./mode-document-prose) |
| Existing diagram + *"is this good?"* | [Review](./mode-review) |
| Existing diagram + *"add/remove X"* | [Update](./mode-update) |

If the mode is ambiguous, the agent will ask one clarifying question.

## Notation Rules (Non-Negotiable)

These rules apply to **every diagram** the agent produces:

### Relationships
- ✅ Every arrow must be **unidirectional** (no `BiRel`)
- ✅ Every arrow must have a **descriptive intent label** — ban `"Uses"`, `"Calls"`, `"Reads"`
- ✅ Inter-container arrows must state the **protocol** (HTTPS, gRPC, AMQP, JDBC…)

### Elements
- ✅ Every `Container` and `Component` must state its **technology** (e.g., `"PostgreSQL 15"`)
- ✅ Every element must have a **short description** of its responsibility
- ✅ **External systems** must be included at the Context level

### Diagram
- ✅ Must have an explicit **title**
- ✅ Must be accompanied by a **Markdown document** (not a bare diagram)
- ✅ No delivery until you explicitly confirm the output

## Output Format

Default: **one Markdown file per level**, with the diagram embedded as Mermaid C4.

Alternative formats (negotiated at the start):
- Structurizr DSL
- PlantUML with C4-PlantUML library
- SVG/PNG export
- Markdown-only (no diagram) for environments that don't render Mermaid

## Example Prompt

```
Act as the C4 Designer. I have an existing Node.js + PostgreSQL API.
Here is the codebase: [paste or point to files]
Please retro-document this system and generate a Level 2 Container Diagram.
```

## Bundled Reference Files

The skill loads additional files on demand:

| File | Purpose |
|------|---------|
| `mode-design.md` | 5-phase greenfield design dialogue |
| `mode-document-code.md` | Retro-doc from a live codebase |
| `mode-document-prose.md` | Retro-doc from README/spec/ADR |
| `mode-review.md` | Critique against Simon Brown's checklist |
| `mode-update.md` | Incremental updates to an existing diagram |
| `mermaid-c4-syntax.md` | Complete Mermaid C4 API reference |
| `review-checklist.md` | Simon Brown's official checklist |
