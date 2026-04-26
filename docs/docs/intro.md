---
slug: /
sidebar_position: 1
---

# Welcome to c4-skills

**c4-skills** is a universal, agent-agnostic "Skill" package that teaches any AI coding agent how to act as an expert Software Architect using the [C4 model](https://c4model.com) and Architecture Decision Records (ADRs).

> AI agents are great at writing code — but they often struggle to design and document software architectures **consistently**. This framework fixes that.

## What you get

Install these skills into your AI agent and it will:

- 🏗️ **Generate C4 diagrams** from your codebase automatically — Context, Container, Component levels
- 📝 **Document architectural decisions** using the standard MADR template
- 🔍 **Review and critique** existing diagrams against Simon Brown's official checklist
- 🔄 **Update diagrams** incrementally as your system evolves

## Quick Start

```bash
# Clone the skills
git clone https://github.com/muthub-ai/c4-skills.git
cd c4-skills

# Install into your target project
./install.sh
```

Then open your AI agent and say:

```
Act as the C4 Designer. Scan my codebase and generate a Level 2 Container Diagram.
```

## The Two Skills

| Skill | Answers | Modes |
|-------|---------|-------|
| **[c4designer](./skills/c4designer)** | *What is the architecture?* | Design, Document-Code, Document-Prose, Review, Update |
| **[adr-scribe](./skills/adr-scribe)** | *Why was it built that way?* | Interview, Retro-Document, Review |

## Supported Agents

| Agent | Install Path | Status |
|-------|-------------|--------|
| GitHub Copilot | `.github/skills/` | ✅ Supported |
| Claude Code | `.claude/skills/` | ✅ Supported |
| Cursor | `.agents/skills/` | ✅ Supported |
| Devin | `.agents/skills/` | ✅ Supported |
| Windsurf | `.agents/skills/` | ✅ Supported |

---

**Next:** [Installation →](./getting-started/installation)
