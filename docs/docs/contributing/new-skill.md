---
sidebar_position: 2
---

# Adding a New Skill

A step-by-step guide to creating a new skill that integrates cleanly with the `c4-skills` framework.

## Step 1: Create the skill directory

```bash
mkdir my-skill
```

## Step 2: Create `SKILL.md` with required frontmatter

Every `SKILL.md` must include this exact YAML block:

```yaml
---
name: my-skill
version: 1.0.0
requires: [] # or ["c4-model >= 1.0.0"] if depends on another skill
compatible_agents: ["copilot", "claude-code", "cursor", "devin", "windsurf"]
description: >
  A 1-3 sentence summary of when the agent should trigger this skill.
  Be specific: list the user signals that should activate it.
---
```

The test suite will fail if any of these fields are missing.

## Step 3: Add mode files (if multiple modes)

If your skill has multiple operational modes, split them into separate files:

```
my-skill/
├── SKILL.md          ← Main entry point + mode router
├── mode-design.md    ← One file per mode
├── mode-review.md
└── examples/
    └── 01-example.md
```

## Step 4: Add an example

Include at least one worked example in `examples/`. The test suite validates that all examples pass the skill's own validator.

## Step 5: Register in `registry.json`

Add your skill to the root `registry.json`:

```json
{
  "id": "my-skill",
  "name": "my-skill",
  "version": "1.0.0",
  "description": "...",
  "requires": [],
  "compatible_agents": ["copilot", "claude-code", "cursor", "devin", "windsurf"],
  "path": "my-skill/SKILL.md",
  "modes": ["design", "review"]
}
```

:::caution
If you forget this step, **Suite 4 (Registry Completeness) will fail** with:
`Skill 'my-skill' is NOT in registry.json`
:::

## Step 6: Write behavioral fixtures

See [Writing Behavioral Tests](./behavioral-tests).

## Step 7: Run the full test suite

```bash
make test
```

All 29+ checks must pass.
