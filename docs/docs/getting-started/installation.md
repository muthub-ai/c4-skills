---
sidebar_position: 1
---

# Installation

Install `c4-skills` into your target project so your AI agent can discover and use the skills automatically.

## Requirements

- Git (to clone the repository)
- Bash (to run `install.sh`)
- One of the [supported AI agents](../intro#supported-agents)

## Option A: Universal Installer (Recommended)

```bash
# 1. Clone c4-skills somewhere on your machine (one-time setup)
git clone https://github.com/muthub-ai/c4-skills.git ~/tools/c4-skills

# 2. Navigate to your project
cd ~/projects/my-app

# 3. Run the installer from wherever you cloned c4-skills
~/tools/c4-skills/install.sh
```

The installer automatically detects your agent environment:
- If `.github/` is present → installs to `.github/skills/` (GitHub Copilot)
- Otherwise → installs to `.agents/skills/` (emerging standard for Devin, Cursor, Windsurf)

Or use `make` if you're inside the `c4-skills` directory:

```bash
cd ~/tools/c4-skills
make install
```

## Option B: Manual Install

Copy the desired skill folders directly into the correct location for your agent.

### GitHub Copilot

```bash
cp -r ~/tools/c4-skills/c4designer  .github/skills/c4designer
cp -r ~/tools/c4-skills/adr-scribe  .github/skills/adr-scribe
```

### Claude Code

```bash
cp -r ~/tools/c4-skills/c4designer  .claude/skills/c4designer
cp -r ~/tools/c4-skills/adr-scribe  .claude/skills/adr-scribe
```

### Cursor / Devin / Windsurf

```bash
cp -r ~/tools/c4-skills/c4designer  .agents/skills/c4designer
cp -r ~/tools/c4-skills/adr-scribe  .agents/skills/adr-scribe
```

## Verify the Installation

After installing, confirm the files are in place:

```bash
ls .github/skills/
# c4designer   adr-scribe
```

Then ask your agent:

```
What skills are available to you? List the skills you found.
```

A correctly installed agent should reference `c4designer` and `adr-scribe` in its response.

## Installing Only One Skill

If you only need C4 diagrams and not ADRs (or vice versa), just copy the folder you need:

```bash
# C4 diagrams only
cp -r ~/tools/c4-skills/c4designer  .github/skills/c4designer

# ADRs only
cp -r ~/tools/c4-skills/adr-scribe  .github/skills/adr-scribe
```

:::note
`adr-scribe` recommends (but does not require) `c4designer`. The two skills work better together — after documenting a decision, `adr-scribe` will suggest using `c4designer` to visualize the resulting architecture.
:::
