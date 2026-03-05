#!/bin/bash
# Hook: post-tool-use (error logger)
# Runs after every tool call. Logs errors to a file for review.
# Place in: .claude/hooks/post-tool-use.sh
# Register in: .claude/settings.json under "hooks.PostToolUse"
#
# Environment variables available:
#   TOOL_NAME        — name of the tool that was called
#   TOOL_EXIT_CODE   — exit code (0 = success, non-zero = error)
#   TOOL_OUTPUT      — stdout from the tool (may be empty for some tools)
#
# What this does:
#   - If exit code is non-zero, appends an entry to .claude/error-log.txt
#   - Keeps last 50 errors only (trims older ones)

LOG_FILE=".claude/error-log.txt"
MAX_ENTRIES=50

# Only log if there was an error
if [ "${TOOL_EXIT_CODE}" != "0" ] && [ "${TOOL_EXIT_CODE}" != "" ]; then
    mkdir -p .claude

    timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    echo "[$timestamp] TOOL=$TOOL_NAME EXIT=$TOOL_EXIT_CODE" >> "$LOG_FILE"

    # Keep only last MAX_ENTRIES lines
    if [ -f "$LOG_FILE" ]; then
        tail -n "$MAX_ENTRIES" "$LOG_FILE" > "$LOG_FILE.tmp" && mv "$LOG_FILE.tmp" "$LOG_FILE"
    fi
fi
