# Behavioral Tests

This directory contains **behavioral fixture tests** for the `c4-skills` framework. Unlike the structural tests (`test-skill-format.sh`), which validate file format and YAML frontmatter, behavioral tests validate the **expected output quality** of AI agents.

## What is a Behavioral Test?

Each subdirectory in `behavioral/` represents one scenario. It contains:

- `prompt.md` — The exact prompt that should be given to the agent.
- `expected.md` — The "golden" output the agent should produce.
- `README.md` — The scenario description, acceptance criteria, and which skill/mode it tests.

The CI runner validates that all `expected.md` files pass the relevant domain validator (`validate-c4-diagram.sh` or `validate-adr.sh`), ensuring they are internally valid. **Human review is required to assess the quality of the agent's actual response.**

## Fixture Index

| Fixture | Skill | Mode | Tests |
|---------|-------|------|-------|
| `01-context-diagram-from-prose` | `c4designer` | `Document-Prose` | Agent correctly identifies Person, System, and Ext System from a README |
| `02-container-diagram-from-code` | `c4designer` | `Document-Code` | Agent correctly maps services in docker-compose to C4 Containers |
| `03-adr-interview-postgresql` | `adr-scribe` | `Interview` | Agent elicits context, options, and consequences across max-3-question batches |

## Running Behavioral Tests

The behavioral tests are automatically run as Suite 3 of the main test runner:

```bash
cd tests
./test-skill-format.sh
```

## Adding a New Fixture

1. Create a new directory: `behavioral/<XX>-<short-description>/`
2. Add `prompt.md`, `expected.md`, and `README.md`
3. Run the test suite to confirm the new fixture is discovered and passes validation
