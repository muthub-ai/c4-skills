#!/bin/bash
set -e

echo "🏗️ c4-skills Universal Installer"
echo "--------------------------------"

# Target default directories for different agents
COPILOT_DIR=".github/skills"
DEVIN_DIR=".agents/skills"
CLAUDE_DIR=".claude/skills"
CURSOR_DIR=".agents/skills"

echo "Detecting environment..."

# Array of targets to install to
TARGETS=()

# Basic heuristics for detection
if [ -d ".github" ]; then
    echo "✅ GitHub Copilot environment detected (.github folder)"
    TARGETS+=("$COPILOT_DIR")
fi

# We'll install to .agents/skills by default as it's the emerging standard
echo "✅ Adding emerging standard directory (.agents/skills)"
TARGETS+=("$DEVIN_DIR")

for target in "${TARGETS[@]}"; do
    echo "Installing to $target..."
    mkdir -p "$target"
    cp -r c4designer "$target/"
    cp -r adr-scribe "$target/"
    echo "✅ Installed c4designer and adr-scribe into $target"
done

echo "🎉 Installation complete! Your AI agent is now equipped with architectural skills."
