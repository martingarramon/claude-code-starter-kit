#!/bin/bash
# Hook Type: Stop
# Purpose: Clean up temp files and generate session summary on exit
# Runs when the Claude Code session terminates

SESSION_DIR="${HOME}/.claude/sessions"
SUMMARY_FILE="${SESSION_DIR}/last-session-summary.md"

mkdir -p "$SESSION_DIR"

# Generate session summary
{
    echo "# Session Summary"
    echo "Ended: $(date)"
    echo ""

    # Git changes made during session
    echo "## Changes"
    if git status --porcelain 2>/dev/null | grep -q .; then
        echo '```'
        git diff --stat 2>/dev/null
        echo '```'
        echo ""
        echo "**Uncommitted changes detected.** Review before closing."
    else
        echo "No uncommitted changes."
    fi
    echo ""

    # Recent commits (last 3)
    echo "## Recent Commits"
    echo '```'
    git log --oneline -3 2>/dev/null || echo "Not a git repository"
    echo '```'
} > "$SUMMARY_FILE"

# Clean up common temp files
find /tmp -name "claude-*" -mmin +60 -delete 2>/dev/null
find /tmp -name "*.claude.tmp" -mmin +60 -delete 2>/dev/null

echo "Session summary saved to $SUMMARY_FILE"
