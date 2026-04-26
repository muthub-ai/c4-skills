# Security Policy

## Supported Versions

We currently support the following version(s) of `c4-skills`.

| Version | Supported          |
| ------- | ------------------ |
| 1.0.0   | :white_check_mark: |

## Safe by Design

The `c4-skills` repository is fundamentally a collection of **Markdown files containing text instructions** for AI agents. 

- This repository contains **NO executable code** that runs in your production environment.
- The skills **never** transmit your proprietary data outside of your active AI session context. Data remains entirely within the environment of the AI agent you are using (e.g., GitHub Copilot, Devin, Cursor).
- The test scripts (`validate-c4-diagram.sh`, etc.) are purely for CI/CD formatting validation and are not run within the agent lifecycle.

## Reporting a Vulnerability

If you discover any security issue (e.g., a prompt injection vector that could cause an agent to act maliciously within the local IDE), please do NOT open a public issue.

Instead, please email the maintainer directly. We aim to respond to all security-related reports within 48 hours.
