#!/bin/bash
# Stop hook: once per session, block the first stop attempt so Claude writes
# a short summary of what happened into today's session log before finishing.
set -euo pipefail
cd "$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

input=$(cat)
session_id=$(echo "$input" | jq -r '.session_id // "unknown"')

STATE_DIR=".claude/sessions/.state"
mkdir -p "$STATE_DIR"
MARKER="$STATE_DIR/$session_id.logged"

if [ -f "$MARKER" ]; then
  echo '{}'
  exit 0
fi
touch "$MARKER"

TODAY=$(date +%Y-%m-%d)
jq -n --arg today "$TODAY" '{decision: "block", reason: ("終了する前に、今日のセッションでやったことの要約を .claude/sessions/" + $today + ".md に箇条書きで簡潔に追記してください。書き終えたら通常通り終了してください。")}'
