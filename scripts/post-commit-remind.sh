#!/bin/bash
# After a git commit, remind to update task status
# Runs on PostToolUse for Bash commands containing "git commit"

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# Only trigger on git commit commands
case "$COMMAND" in
  *"git commit"*|*"git add"*"&&"*"git commit"*)
    ;;
  *)
    exit 0
    ;;
esac

# Check if tasks.md exists and has in-progress tasks
if [ -f ".claude/tasks.md" ]; then
  IN_PROGRESS=$(grep -c '`IN_PROGRESS`\|`TESTING`\|`READY`' .claude/tasks.md 2>/dev/null || echo "0")
  if [ "$IN_PROGRESS" -gt 0 ]; then
    echo "Committed. Remember to update task status in .claude/tasks.md ($IN_PROGRESS task(s) in progress)."
  fi
fi

exit 0
