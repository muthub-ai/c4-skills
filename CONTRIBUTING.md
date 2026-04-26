# Contributing to c4-skills

First off, thank you for considering contributing to `c4-skills`! 

This project aims to become the definitive, open-source library of architectural skills for AI Coding Agents. By contributing, you help thousands of developers automate the hardest parts of software design.

## 🛠️ How to Contribute

### 1. Reporting Bugs
Found an issue where the AI agent hallucinated, broke syntax, or failed validation?
- Open an Issue with the tag `bug`.
- Include the **Agent** you were using (e.g., Cursor, Copilot).
- Include the **exact prompt** you used and the **raw output** that failed.

### 2. Proposing a New Skill
We welcome new architectural skills! If you want to add something like `threat-model` (STRIDE) or `data-model` (Entity-Relationship), please follow these guidelines:

#### A. The `SKILL.md` Frontmatter
Every new skill must sit in its own top-level directory and have a `SKILL.md` file. It **must** include this exact YAML frontmatter block at the top:
```yaml
---
name: your-skill-name
version: 1.0.0
requires: [] # or ["c4-model >= 1.0.0"] if it depends on another skill
compatible_agents: ["copilot", "claude-code", "cursor", "devin", "windsurf"]
description: A 1-3 sentence summary of when the agent should trigger this skill.
---
```

#### B. Skill Structure
- **Keep it modular:** If your skill has multiple "modes" (e.g., design, review), split them into separate files like `mode-design.md` and `mode-review.md`. 
- **Include Examples:** Agents learn by example. Include an `examples/` directory inside your skill folder.

### 3. Adding Behavioral Tests (Crucial!)
We enforce a strict behavioral testing standard. If you add a feature or a new skill, you **must** write a test for it.

Behavioral fixtures live in `tests/behavioral/`. To add one:
1. Create a new directory: `tests/behavioral/my-new-test/`
2. Add a `prompt.md` containing the exact prompt you'd give an agent. **It must include an `## Acceptance Criteria` section.**
3. Add an `expected.md` containing the "golden" output you expect the agent to generate.
4. Add a `skill.txt` containing the name of your skill directory (e.g., `adr-scribe`) so the test runner knows which validator to route it to.

*Note: Prefix your directory with `negative-` (e.g., `negative-bad-syntax`) if the test is expected to fail validation.*

## 🚀 Pull Request Checklist

Before submitting a PR, ensure you have run the test suite locally and everything passes:

```bash
# If you don't have make, you can run: cd tests && ./test-skill-format.sh
make test
```

When you open a PR, the CI action will automatically run the Structural, Sandbox, and Behavioral suites against your branch.

## 📜 Code of Conduct
Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.
