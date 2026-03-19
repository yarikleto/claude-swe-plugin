#!/bin/bash
# Auto-format files after Edit/Write operations
# Runs the project's formatter if available, silently skips if not

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [ -z "$FILE_PATH" ] || [ ! -f "$FILE_PATH" ]; then
  exit 0
fi

# Skip non-code files
case "$FILE_PATH" in
  *.md|*.json|*.yml|*.yaml|*.toml|*.txt|*.csv|*.svg|*.html) exit 0 ;;
  *.lock|*.lockb|*.map) exit 0 ;;
esac

# Try formatters in order of preference (fail silently if none available)
if [ -f "node_modules/.bin/prettier" ]; then
  npx prettier --write "$FILE_PATH" 2>/dev/null
elif [ -f "node_modules/.bin/biome" ]; then
  npx biome format --write "$FILE_PATH" 2>/dev/null
elif command -v gofmt &>/dev/null && [[ "$FILE_PATH" == *.go ]]; then
  gofmt -w "$FILE_PATH" 2>/dev/null
elif command -v rustfmt &>/dev/null && [[ "$FILE_PATH" == *.rs ]]; then
  rustfmt "$FILE_PATH" 2>/dev/null
elif command -v black &>/dev/null && [[ "$FILE_PATH" == *.py ]]; then
  black --quiet "$FILE_PATH" 2>/dev/null
fi

exit 0
