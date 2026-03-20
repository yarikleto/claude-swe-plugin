#!/bin/bash
# After editing a task file to DONE status, remind to run /compact
# Runs on PostToolUse for Edit tool

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
NEW_STRING=$(echo "$INPUT" | jq -r '.tool_input.new_string // empty')

# Only trigger on task file edits that set status to DONE
case "$FILE_PATH" in
  *.claude/tasks/TASK-*)
    ;;
  *)
    exit 0
    ;;
esac

# Check if this edit is setting status to DONE
case "$NEW_STRING" in
  *'`DONE`'*)
    echo "Task marked DONE. Run /compact to free context for the next task." >&2
    ;;
esac

exit 0
