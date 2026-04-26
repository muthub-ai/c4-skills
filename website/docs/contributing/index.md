---
sidebar_position: 1
---

# Contributing Overview

Thank you for considering contributing to `c4-skills`!

This project aims to become the definitive, open-source library of architectural skills for AI Coding Agents.

## Ways to contribute

| Type | Description |
|------|-------------|
| 🐛 **Bug report** | An agent produced invalid output that should have been caught |
| 📖 **Documentation** | Improve or add to this documentation site |
| 🧠 **New skill** | Add a new architectural skill (e.g., `threat-model`, `data-model`) |
| 🧪 **Behavioral test** | Add a fixture that tests a new scenario |

## Before you start

Run the full test suite to establish a baseline:

```bash
make test
```

All 4 suites (Structural, Sandbox, Behavioral, Registry) must pass before and after your change.

## Sections

- [Adding a New Skill](./new-skill) — Full guide to authoring and registering a new skill
- [Writing Behavioral Tests](./behavioral-tests) — How to write prompt/expected-output fixtures
