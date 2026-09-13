#!/bin/bash
# SessionStart hook: creates/opens today's session log and feeds recent
# session history back into context automatically.
set -euo pipefail
cd "$(git rev-parse --show-toplevel 2>/dev/null || pwd)"

DIR=".claude/sessions"
TODAY=$(date +%Y-%m-%d)
TODAY_FILE="$DIR/$TODAY.md"
mkdir -p "$DIR"

if [ ! -f "$TODAY_FILE" ]; then
  printf '# %s\n\n' "$TODAY" > "$TODAY_FILE"
fi
printf -- '- %s セッション開始\n' "$(date +%H:%M)" >> "$TODAY_FILE"

RECENT=$(ls -1 "$DIR"/*.md 2>/dev/null | sort -r | head -3)
CONTEXT="## 直近の作業ログ (.claude/sessions/)"$'\n\n'
for f in $RECENT; do
  CONTEXT+="### $(basename "$f")"$'\n'
  CONTEXT+="$(cat "$f")"$'\n\n'
done

jq -n --arg ctx "$CONTEXT" '{hookSpecificOutput: {hookEventName: "SessionStart", additionalContext: $ctx}}'
