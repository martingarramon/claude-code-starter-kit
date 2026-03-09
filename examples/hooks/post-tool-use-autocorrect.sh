#!/bin/bash
# Hook Type: PostToolUse
# Purpose: Auto-lint and format files after Claude creates or edits them
# Runs appropriate linter/formatter based on file extension

payload=$(cat)
tool_name=$(echo "$payload" | jq -r '.tool_name // empty')
exit_code=$(echo "$payload" | jq -r '.exit_code // 0')

# Only process successful file writes
if [ "$exit_code" != "0" ]; then
    echo '{"status":"continue"}'
    exit 0
fi

if [ "$tool_name" = "Write" ] || [ "$tool_name" = "Edit" ]; then
    filepath=$(echo "$payload" | jq -r '.tool_args.file_path // .tool_args.filepath // empty')

    [ -z "$filepath" ] || [ ! -f "$filepath" ] && { echo '{"status":"continue"}'; exit 0; }

    case "$filepath" in
        *.py)
            command -v black > /dev/null 2>&1 && black --quiet "$filepath" 2>/dev/null
            ;;
        *.js|*.ts|*.jsx|*.tsx)
            command -v prettier > /dev/null 2>&1 && npx prettier --write "$filepath" 2>/dev/null
            ;;
        *.go)
            command -v gofmt > /dev/null 2>&1 && gofmt -w "$filepath" 2>/dev/null
            ;;
        *.rs)
            command -v rustfmt > /dev/null 2>&1 && rustfmt "$filepath" 2>/dev/null
            ;;
    esac
fi

echo '{"status":"continue"}'
