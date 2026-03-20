#!/bin/bash

# Check auto-compact setting — model performs best under 100k tokens
if [ -z "$CLAUDE_AUTOCOMPACT_PCT_OVERRIDE" ]; then
  echo "WARNING: CLAUDE_AUTOCOMPACT_PCT_OVERRIDE is not set. For best performance, set it to 10 (auto-compact at ~100k tokens)." >&2
  echo "Add to your project .claude/settings.json:" >&2
  echo '  { "env": { "CLAUDE_AUTOCOMPACT_PCT_OVERRIDE": "10" } }' >&2
  echo "" >&2
fi

CEO_BRAIN=".claude/ceo-brain.md"

if [ -f "$CEO_BRAIN" ]; then
  echo "=== CEO KNOWLEDGE BASE ==="
  cat "$CEO_BRAIN"
  echo "=== END CEO KNOWLEDGE BASE ==="
  echo ""
  echo "Your knowledge base is loaded. If it feels outdated, run /claude-swe-plugin:swe-sync to refresh."
else
  echo "=== NO CEO KNOWLEDGE BASE FOUND ==="
  echo ""
  echo "You have no strategic knowledge base for this project yet."
  echo "Run /claude-swe-plugin:swe-brief to study the project and build your knowledge base."
  echo "Until then, you are flying blind — avoid making architectural decisions without intel."
fi
