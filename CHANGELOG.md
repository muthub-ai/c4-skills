# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

> Changes on `feat-updatec4` branch, pending merge to `main`.

### 🚀 Added
- **`adr-scribe` Mode Files**: Decomposed the monolithic skill into three dedicated workflow files — `mode-interview.md`, `mode-retro-document.md`, and `mode-review.md` — each with phased, structured dialogue matching the depth of `c4designer`.
- **Intelligent Mode Routing**: `adr-scribe` now includes a "Signals to infer without asking" table, allowing agents to auto-detect the correct mode from user phrasing without prompting.
- **Behavioral Test Suite**: Added `tests/behavioral/` containing scenario-based prompt-response fixtures that validate agent behavior, not just file structure.
- **ADR Validator**: New `tests/validate-adr.sh` script that enforces MADR section completeness, including the presence of negative consequences.
- **`install.sh`**: A universal installer that auto-detects the target agent and copies skills to the correct discovery directory.
- **`SECURITY.md`**: Formally documents the security posture (text-only instructions, no data exfiltration) and vulnerability reporting process.
- **Enterprise Metadata**: Added `requires:` and `compatible_agents:` fields to all `SKILL.md` YAML frontmatter to support future skill registries.
- **Agent Compatibility Matrix**: Added a cross-agent compatibility table to `README.md`.
- **Visual Preview**: Added a rendered Mermaid C4 diagram to `README.md` so users immediately understand the output format.

### 🔧 Fixed
- **Bare intent labels**: Eliminated all instances of `"Uses"`, `"Calls"`, and `"Reads"` from `README.md` and `supporting-diagrams.md`. These violated the same C4 rules the skills enforce.
- **Validator regex**: Hardened `validate-c4-diagram.sh` to use `(Container|ContainerDb|ContainerQueue)` instead of `Container(|Db|Queue)` to prevent empty-group matching in bash.
- **Missing protocol**: Fixed a missing HTTPS protocol tag on a `Rel` in `c4designer/examples/02-container.example.md`.

### 📐 Changed
- **CI triggers**: `.github/workflows/test.yml` now runs on **all branches** (`**`), not just `main`, to provide immediate feedback on feature branches.
- **YAML validation**: `test-skill-format.sh` now enforces `version:`, `requires:`, and `compatible_agents:` in all `SKILL.md` frontmatter.
- **Bidirectional cross-skill integration**: `adr-scribe` modes now suggest using `c4designer` after documenting a decision, completing the two-way feedback loop.

---

## [1.1.0] — 2026-04-26

This release generalizes the repository from a single-skill tool into a **multi-skill architectural framework**, and establishes enterprise-grade community and testing standards.

### 🚀 Added
- **`adr-scribe` skill** — A complete, structured skill for drafting, retro-documenting, and reviewing Architecture Decision Records using the Michael Nygard MADR template. This pairs with `c4designer` to answer both *"what is the architecture?"* and *"why was it built that way?"*
- **Example ADR** — `adr-scribe/examples/0001-use-postgresql-over-mongodb.md`, a fully filled-out MADR for the Internet Banking sandbox, demonstrating the expected output quality.
- **ADR Review Checklist** — `adr-scribe/review-checklist.md` enforcing balance between positive and negative consequences.
- **`example-codebase` sandbox** — A realistic mock Internet Banking System (`React` SPA + `Node.js/Express` API + `PostgreSQL`) with annotated source files, enabling safe AI agent testing without exposing proprietary code.
- **Golden diagram outputs** — `tests/example-codebase/diagrams/context.md` and `container.md` serve as the expected "ground truth" for sandbox tests.
- **C4 Diagram Validator** — `tests/validate-c4-diagram.sh` parses generated Mermaid C4 files and enforces: presence of a title, valid graph types, descriptive `Rel` intent labels, and technology tags on `Container` elements.
- **GitHub Actions CI** — `.github/workflows/test.yml` automates the full test suite on every push and pull request.
- **Community standards** — `CODE_OF_CONDUCT.md` (Contributor Covenant v2.1) and `CONTRIBUTING.md` with skill authorship guidelines.
- **Cross-skill integration** — `c4designer/mode-update.md` now proactively suggests invoking `adr-scribe` when significant structural changes are detected.

### 📐 Changed
- **Test runner generalized** — `tests/test-skill-format.sh` now dynamically discovers all `SKILL.md` files, enabling zero-config validation of any new skill added to the repo.
- **`README.md` overhauled** — Unified introduction (removing audience splits), added example prompts for each skill mode, and improved installation instructions for all major agents.
- **YAML frontmatter versioning** — Added `version: 1.0.0` to both `c4designer` and `adr-scribe` YAML frontmatter.

---

## [1.0.0] — 2026-04-26 (Initial Release)

The first public release of the `c4-skills` framework — a universal, agent-agnostic skill package that teaches any AI coding agent to act as an expert software architect.

### 🚀 Added
- **`c4designer` skill** — A deeply structured 14,000-byte skill file implementing Simon Brown's C4 model across 5 operational modes:
  - `mode-design.md` — 5-phase greenfield architecture dialogue with explicit validation checkpoints.
  - `mode-document-code.md` — Retro-documentation from scanning a live codebase.
  - `mode-document-prose.md` — Retro-documentation from READMEs, specs, and design documents.
  - `mode-review.md` — Structured critique against Simon Brown's official C4 review checklist.
  - `mode-update.md` — Incremental updates to an existing diagram with regression-awareness.
- **Reference material** — `mermaid-c4-syntax.md` (complete Mermaid C4 API reference), `review-checklist.md`, `level-template.md`, `supporting-diagrams.md` (System Landscape, C4Deployment, C4Dynamic).
- **Worked examples** — `c4designer/examples/01-context.example.md` and `02-container.example.md` for the Internet Banking System.
- **Structural test runner** — `tests/test-skill-format.sh` for validating `SKILL.md` file format and YAML frontmatter.
- **MIT License** — Copyright © Muthu B.

---

[Unreleased]: https://github.com/muthub-ai/c4-skills/compare/v1.1.0...HEAD
[1.1.0]: https://github.com/muthub-ai/c4-skills/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/muthub-ai/c4-skills/releases/tag/v1.0.0
