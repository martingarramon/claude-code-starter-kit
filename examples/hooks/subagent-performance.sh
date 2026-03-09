#!/bin/bash
# Hook Type: SubagentStop
# Purpose: Log sub-agent execution metrics for performance analysis
# Tracks duration, success rate, and output quality

payload=$(cat)
agent_name=$(echo "$payload" | jq -r '.subagent_name // "unknown"')
task=$(echo "$payload" | jq -r '.task_description // ""')
status=$(echo "$payload" | jq -r '.status // "unknown"')
start_time=$(echo "$payload" | jq -r '.start_time // 0')
end_time=$(echo "$payload" | jq -r '.end_time // 0')

LOG_FILE="${HOME}/.claude/subagent-metrics.jsonl"

# Calculate duration
if [ "$start_time" != "0" ] && [ "$end_time" != "0" ]; then
    duration=$((end_time - start_time))
else
    duration=0
fi

# Log as JSONL for easy analysis
echo "{\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"agent\":\"$agent_name\",\"task\":\"$task\",\"status\":\"$status\",\"duration_seconds\":$duration}" >> "$LOG_FILE"

# Alert if sub-agent took too long (>120 seconds)
if [ "$duration" -gt 120 ]; then
    echo "[WARN] Sub-agent '$agent_name' took ${duration}s (>2min threshold)" >&2
fi

echo '{"status":"continue"}'
