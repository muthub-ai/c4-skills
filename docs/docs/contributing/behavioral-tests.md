---
sidebar_position: 3
---

# Writing Behavioral Tests

Behavioral fixtures validate that the expected output of an AI agent passes the domain-specific validator.

## Fixture structure

```
tests/behavioral/my-test/
├── prompt.md     ← The exact prompt you'd give an agent
├── expected.md   ← The golden output the agent should produce
└── skill.txt     ← Routes to the right validator (c4designer or adr-scribe)
```

## Requirements

- `prompt.md` **must** contain an `## Acceptance Criteria` section or CI fails
- `skill.txt` must contain exactly `c4designer` or `adr-scribe`
- `expected.md` must pass the corresponding validator

## Negative test fixtures

Prefix with `negative-` to assert that the validator **rejects** the output:

```
tests/behavioral/negative-my-bad-case/
```

The test runner expects these to fail validation. If they pass, the test fails — proving the linter actually works.

## Running fixtures

```bash
make test
```
