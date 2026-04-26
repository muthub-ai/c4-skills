#!/bin/bash
set -e

# Usage: ./validate-adr.sh <path-to-markdown-file>

FILE=$1

if [ -z "$FILE" ]; then
    echo "Usage: $0 <path-to-markdown-file>"
    exit 1
fi

if [ ! -f "$FILE" ]; then
    echo "❌ File not found: $FILE"
    exit 1
fi

echo "Validating ADR syntax in: $FILE"

# Check for Status
if ! grep -q '\* Status:' "$FILE"; then
    echo "❌ Missing '* Status:' field in ADR"
    exit 1
fi

# Check for Context
if ! grep -Eq '^## Context' "$FILE"; then
    echo "❌ Missing '## Context' section in ADR"
    exit 1
fi

# Check for Considered Options
if ! grep -Eq '^## Considered Options' "$FILE"; then
    echo "❌ Missing '## Considered Options' section in ADR. A decision implies alternatives."
    exit 1
fi

# Check for Decision
if ! grep -Eq '^## Decision Outcome' "$FILE"; then
    echo "❌ Missing '## Decision Outcome' section in ADR"
    exit 1
fi

# Check for Negative Consequences
if ! grep -Eq '^### Negative Consequences' "$FILE"; then
    echo "❌ Missing '### Negative Consequences' section in ADR. Every decision has trade-offs."
    exit 1
fi

echo "✅ $FILE is a valid Architecture Decision Record"
exit 0
