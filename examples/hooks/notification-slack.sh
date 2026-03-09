#!/bin/bash
# Hook Type: Notification
# Purpose: Send alerts to Slack when Claude performs important actions
# Set SLACK_WEBHOOK_URL environment variable before use
# Triggers on: deployments, PR creation, critical errors

payload=$(cat)
event_type=$(echo "$payload" | jq -r '.event_type // empty')
message=$(echo "$payload" | jq -r '.message // empty')
details=$(echo "$payload" | jq -r '.details // empty')

WEBHOOK="${SLACK_WEBHOOK_URL:-}"

if [ -z "$WEBHOOK" ]; then
    exit 0  # Silently skip if no webhook configured
fi

send_slack() {
    local text="$1"
    curl -s -X POST -H 'Content-type: application/json' \
        --data "{\"text\":\"$text\"}" \
        "$WEBHOOK" > /dev/null 2>&1
}

case "$event_type" in
    "deployment")
        env=$(echo "$details" | jq -r '.environment // "unknown"')
        send_slack ":rocket: *Deployment Complete*\nEnvironment: \`$env\`\nMessage: $message"
        ;;
    "pull_request")
        url=$(echo "$details" | jq -r '.url // ""')
        send_slack ":git: *Pull Request Created*\n$message\n<$url|View PR>"
        ;;
    "error")
        send_slack ":x: *Error in Claude Session*\n\`\`\`$message\`\`\`"
        ;;
    "task_complete")
        send_slack ":white_check_mark: *Task Complete*\n$message"
        ;;
esac
