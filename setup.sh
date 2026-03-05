#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-.}"

if [ "$TARGET" = "." ]; then
  echo "Usage: ./setup.sh /path/to/your/project"
  echo "This will create the starter kit structure in the target directory."
  echo "Existing files will NOT be overwritten."
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Create directories
mkdir -p "$TARGET/skills/research"
mkdir -p "$TARGET/skills/debugging"
mkdir -p "$TARGET/skills/proposal-writing"
mkdir -p "$TARGET/memory"
mkdir -p "$TARGET/.claude"

# Copy files (skip if they already exist)
copy_if_missing() {
  local src="$1" dest="$2"
  if [ -f "$dest" ]; then
    echo "  SKIP  $dest (already exists)"
  else
    cp "$src" "$dest"
    echo "  COPY  $dest"
  fi
}

echo "Setting up Claude Code starter kit in: $TARGET"
echo ""

copy_if_missing "$SCRIPT_DIR/CLAUDE.md" "$TARGET/CLAUDE.md"
copy_if_missing "$SCRIPT_DIR/skills/research/SKILL.md" "$TARGET/skills/research/SKILL.md"
copy_if_missing "$SCRIPT_DIR/skills/debugging/SKILL.md" "$TARGET/skills/debugging/SKILL.md"
copy_if_missing "$SCRIPT_DIR/skills/proposal-writing/SKILL.md" "$TARGET/skills/proposal-writing/SKILL.md"
copy_if_missing "$SCRIPT_DIR/memory/MEMORY.md" "$TARGET/memory/MEMORY.md"
copy_if_missing "$SCRIPT_DIR/.claude/settings.json" "$TARGET/.claude/settings.json"

echo ""
echo "Setup complete."
echo ""
echo "Next steps:"
echo "  1. Edit CLAUDE.md -- fill in your project context and environment"
echo "  2. Edit memory/MEMORY.md -- add your current project status"
echo "  3. Review skills/ -- keep what applies, delete what doesn't"
echo "  4. Add new rules to CLAUDE.md as Claude makes mistakes"
