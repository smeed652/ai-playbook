#!/bin/bash
#
# Initialize a new project with ai-playbook structure
#
# Usage: ./init-project.sh /path/to/new-project [project-name]
#

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLAYBOOK_DIR="$(dirname "$SCRIPT_DIR")"

PROJECT_PATH="${1:-.}"
PROJECT_NAME="${2:-$(basename "$PROJECT_PATH")}"

if [ "$PROJECT_PATH" = "." ]; then
    PROJECT_PATH="$(pwd)"
fi

echo "🚀 Initializing project: $PROJECT_NAME"
echo "   Location: $PROJECT_PATH"
echo ""

# Create project directory if needed
mkdir -p "$PROJECT_PATH"

# Create .claude directory structure
mkdir -p "$PROJECT_PATH/.claude"

# Copy project template CLAUDE.md
if [ -f "$PLAYBOOK_DIR/templates/project/CLAUDE.md" ]; then
    cp "$PLAYBOOK_DIR/templates/project/CLAUDE.md" "$PROJECT_PATH/CLAUDE.md"
    echo "✓ Created CLAUDE.md"
fi

# Copy .claude project settings if they exist
if [ -d "$PLAYBOOK_DIR/templates/project/.claude" ]; then
    cp -r "$PLAYBOOK_DIR/templates/project/.claude/"* "$PROJECT_PATH/.claude/" 2>/dev/null || true
    echo "✓ Created .claude/ directory"
fi

# Create docs/sprints structure
mkdir -p "$PROJECT_PATH/docs/sprints/0-backlog"
mkdir -p "$PROJECT_PATH/docs/sprints/1-todo"
mkdir -p "$PROJECT_PATH/docs/sprints/2-in-progress"
mkdir -p "$PROJECT_PATH/docs/sprints/3-done"
mkdir -p "$PROJECT_PATH/docs/sprints/4-archive"
mkdir -p "$PROJECT_PATH/docs/sprints/5-abandoned"
echo "1" > "$PROJECT_PATH/docs/sprints/next-sprint.txt"
echo "✓ Created docs/sprints/ structure"

# Create initial sprint template
if [ -f "$PLAYBOOK_DIR/templates/sprint-template.md" ]; then
    cp "$PLAYBOOK_DIR/templates/sprint-template.md" "$PROJECT_PATH/docs/sprints/"
    echo "✓ Added sprint template"
fi

echo ""
echo "✅ Project initialized!"
echo ""
echo "Next steps:"
echo "  1. cd $PROJECT_PATH"
echo "  2. Edit CLAUDE.md with project-specific instructions"
echo "  3. Run /sprint-new to create your first sprint"
echo ""
