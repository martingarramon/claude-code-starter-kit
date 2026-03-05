#!/bin/bash
# Hook: session-start
# Runs at the beginning of every Claude Code session.
# Place in: .claude/hooks/session-start.sh
# Register in: .claude/settings.json under "hooks.SessionStart"
#
# What this does:
#   1. Shows git status so Claude knows what's in progress
#   2. Reminds Claude to read memory before responding
#   3. Reports any uncommitted changes so nothing gets lost

echo "=== SESSION START ==="
echo ""

# Git status
if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    branch=$(git branch --show-current 2>/dev/null)
    echo "Branch: $branch"

    changes=$(git status --short 2>/dev/null)
    if [ -n "$changes" ]; then
        echo "Uncommitted changes:"
        echo "$changes"
    else
        echo "Working tree: clean"
    fi

    # Show last commit
    last_commit=$(git log -1 --format="%h %s" 2>/dev/null)
    echo "Last commit: $last_commit"
else
    echo "Not a git repository."
fi

echo ""
echo "REMINDER: Read memory/MEMORY.md before your first response."
echo "===================="
