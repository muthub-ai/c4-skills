---
sidebar_label: "Mode: Document Code"
sidebar_position: 2
---

# Document-Code Mode

Use this mode to **retro-document an existing codebase**. The agent scans your files and generates C4 diagrams from what it finds — no design dialogue required.

## When it activates

- You paste or reference a code snippet
- You say *"here's my codebase"* or provide a repo path
- *"Retro-document this codebase"*

## How to trigger it

**Option 1: Paste relevant files**
```
Act as the C4 Designer. Please retro-document this system and generate
a Level 2 Container Diagram.

[paste contents of package.json, docker-compose.yml, index.js, etc.]
```

**Option 2: Point to a directory** (agents that can read the filesystem)
```
Act as the C4 Designer. Scan the src/ directory and generate
a Level 2 Container Diagram.
```

## What the agent scans

The agent looks for these signals:

| File | What it reveals |
|------|----------------|
| `package.json`, `pom.xml`, `requirements.txt` | Technology stack, key dependencies |
| `docker-compose.yml`, `Dockerfile` | Container boundaries, environment vars |
| `*.env.example`, `config/*.yml` | External services (DBs, queues, APIs) |
| Route files, controller files | API surface area |
| Import/require statements | Inter-module dependencies |

## Expected output

The agent produces a Markdown file with:
1. **Level 1 Context diagram** — system + actors + external systems inferred from config
2. **Level 2 Container diagram** — services, databases, queues identified from code
3. **Assumptions section** — anything guessed, not found explicitly in the code
4. **Key relationships table** — source, destination, inferred protocol

## Complex Input: Monorepo

For large monorepos, prompt the agent to focus:

```
Act as the C4 Designer in Document-Code mode. Focus only on the
services/payments/ directory. Ignore the frontend/ directory.
Generate a Level 3 Component Diagram for the payments service.
```

## Limitations & exceptions

:::caution
The agent **cannot execute code**. It infers architecture from static analysis only.

If a service dynamically discovers other services (e.g., via Kubernetes service mesh or a service registry), the agent **cannot infer these connections**. You must tell it explicitly.
:::

:::note
If the codebase is very large (50+ files), the agent will ask you to focus on specific files rather than scanning everything at once.
:::
