#!/bin/bash
#
# Set up ~/.claude symlinks to ai-playbook
# Run this on a new machine after cloning ai-playbook
#
# Usage: ./setup-claude.sh
#

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLAYBOOK_DIR="$(dirname "$SCRIPT_DIR")"

echo "🔧 Setting up Claude Code with ai-playbook"
echo "   Playbook: $PLAYBOOK_DIR"
echo ""

# Create ~/.claude if it doesn't exist
mkdir -p ~/.claude

# Function to create symlink with backup
create_symlink() {
    local source="$1"
    local target="$2"
    local name="$(basename "$target")"

    if [ -L "$target" ]; then
        # Already a symlink, update it
        rm "$target"
        ln -s "$source" "$target"
        echo "✓ Updated symlink: $name"
    elif [ -e "$target" ]; then
        # Exists but not a symlink, backup and replace
        mv "$target" "${target}.backup.$(date +%Y%m%d%H%M%S)"
        ln -s "$source" "$target"
        echo "✓ Created symlink: $name (backed up existing)"
    else
        # Doesn't exist, create fresh
        ln -s "$source" "$target"
        echo "✓ Created symlink: $name"
    fi
}

# Create symlinks
create_symlink "$PLAYBOOK_DIR/commands" ~/.claude/commands
create_symlink "$PLAYBOOK_DIR/agents" ~/.claude/agents
create_symlink "$PLAYBOOK_DIR/templates" ~/.claude/templates
create_symlink "$PLAYBOOK_DIR/skills" ~/.claude/skills
create_symlink "$PLAYBOOK_DIR/sprint-steps.json" ~/.claude/sprint-steps.json

echo ""
echo "✅ Claude Code configured!"
echo ""
echo "Symlinks created in ~/.claude:"
ls -la ~/.claude | grep "^l"
echo ""
