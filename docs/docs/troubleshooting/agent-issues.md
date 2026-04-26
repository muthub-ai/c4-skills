---
sidebar_position: 3
---

# Agent-Specific Issues

Known quirks and workarounds for specific AI agents.

---

## GitHub Copilot

### Skill not discovered

**Symptom:** Copilot does not reference the skill when you prompt it.

**Cause:** Copilot requires the skill file to be in `.github/skills/` in the **root of the repository** it is currently working in. It does not discover skills in parent directories.

**Fix:**
```bash
# Make sure you're in the root of your target project
cd ~/projects/my-app
ls .github/skills/
# Should show: c4designer   adr-scribe
```

### Copilot produces diagrams without running the dialogue

**Symptom:** Copilot outputs a diagram immediately without asking clarifying questions.

**Cause:** Copilot sometimes summarizes skill instructions rather than following them step-by-step.

**Fix:** Be explicit in your prompt:
```
Act as the C4 Designer. Do NOT produce any diagram yet.
First, ask me the framing questions from the skill.
```

---

## Claude Code

### Skill files not loaded

**Symptom:** Claude Code ignores the skill and produces a generic diagram.

**Fix:** Explicitly reference the skill file in your prompt:
```
Read the file at .claude/skills/c4designer/SKILL.md and follow its
instructions. Then generate a Level 2 Container Diagram.
```

---

## Cursor

### `.cursorrules` vs `.agents/skills/`

Cursor primarily uses `.cursorrules` for context injection. The `.agents/skills/` directory is supported but may require explicitly adding it to Cursor's context.

**Fix:** Add to your `.cursorrules`:
```
When the user asks for C4 diagrams or architecture documentation,
read and follow the instructions in .agents/skills/c4designer/SKILL.md.
```

---

## General Issues

### Agent produces `BiRel` instead of two `Rel` statements

**Symptom:** The agent uses `BiRel(a, b, "...")` which is valid Mermaid but violates C4 rules (hides intent of each direction).

**Fix:** Tell the agent:
```
Replace all BiRel with two separate Rel statements — one for each direction.
Each Rel must have its own descriptive label.
```

### Agent uses "Uses" as the Rel label

**Symptom:** `Rel(customer, system, "Uses")` appears in the output.

**Fix:** The agent missed the notation rules. Prompt:
```
The label "Uses" is forbidden. Replace it with a specific intent that
describes what the actor is actually doing. For example:
"Views account balances and makes payments using".
```

### Diagram is too dense (15+ elements)

**Symptom:** The agent puts every service in a single diagram, making it unreadable.

**Fix:**
```
This diagram is too dense. Split it into:
1. A System Landscape showing all systems
2. Individual Container diagrams for each bounded context
```
