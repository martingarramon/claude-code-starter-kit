#!/bin/bash
# Hook Type: PreToolUse
# Purpose: Block dangerous commands before Claude executes them
# Reads JSON payload from stdin with tool_name and tool_args
# Returns {"status":"blocked","reason":"..."} to prevent execution
# Returns {"status":"continue"} to allow

payload=$(cat)
tool_name=$(echo "$payload" | jq -r '.tool_name // empty')
tool_args=$(echo "$payload" | jq -r '.tool_args // empty')

LOG_FILE="${HOME}/.claude/security-audit.log"

log_event() {
    echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] $1 | Tool: $tool_name" >> "$LOG_FILE"
}

# Block destructive shell commands
if [ "$tool_name" = "Bash" ] || [ "$tool_name" = "exec_command" ]; then
    command=$(echo "$tool_args" | jq -r '.command // empty')

    if echo "$command" | grep -Eq '(rm -rf /|rm -rf \*|mkfs|dd if=|chmod 777|> /dev/sd|fork bomb)'; then
        log_event "BLOCKED - Destructive command: $command"
        echo '{"status":"blocked","reason":"Command blocked by security policy: destructive operation detected."}'
        exit 0
    fi

    if echo "$command" | grep -Eq '(curl.*\| ?sh|wget.*\| ?sh|eval.*\$\()'; then
        log_event "BLOCKED - Remote code execution: $command"
        echo '{"status":"blocked","reason":"Command blocked: remote code execution pattern detected."}'
        exit 0
    fi
fi

# Block file writes to sensitive paths
if [ "$tool_name" = "Write" ] || [ "$tool_name" = "Edit" ]; then
    filepath=$(echo "$tool_args" | jq -r '.file_path // .filepath // empty')

    if echo "$filepath" | grep -Eq '(/etc/|/usr/|\.ssh/|\.env$|credentials|\.aws/)'; then
        log_event "BLOCKED - Sensitive file write: $filepath"
        echo '{"status":"blocked","reason":"Write blocked: sensitive file path detected."}'
        exit 0
    fi
fi

echo '{"status":"continue"}'
