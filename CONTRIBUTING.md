# Contributing to c4-skills

First off, thank you for considering contributing to `c4-skills`! It's people like you that make this tool great.

## How Can I Contribute?

### Reporting Bugs
If you find that an AI agent is consistently failing to understand a skill instruction, please open an issue! Be sure to include:
- The AI Agent you are using (e.g., GitHub Copilot, Claude Code, Devin, Cursor).
- The exact prompt you used.
- The unexpected output.

### Proposing a New Skill
We welcome new architectural skills! To propose a new skill:
1. Open an issue describing the skill and its purpose.
2. If approved, create a new directory (e.g., `new-skill/`).
3. Ensure you have a `SKILL.md` with proper YAML frontmatter (including `name`, `version`, and `description`).
4. Include any necessary templates, checklists, and examples.
5. Update `tests/TEST_PROMPTS.md` with instructions on how to invoke the new skill.

### Pull Requests
1. Fork the repo and create your branch from `main`.
2. Make your changes.
3. Run the tests locally: `cd tests && ./test-skill-format.sh`
4. Ensure your PR description clearly describes the problem and solution.

## Styleguides
- **Markdown:** Keep markdown clean and readable. Use emojis purposefully for structure, not just decoration.
- **Skill Instructions:** When writing prompts or rules for the AI, be extremely explicit. Use imperatives ("Do X", "Never do Y"). Avoid vague phrasing.

Thank you for contributing!
