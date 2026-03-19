#!/bin/bash
# Iron Rule enforcement: developer can't touch test files, tester can't touch production files
# This hook runs on PreToolUse for Edit and Write tools

INPUT=$(cat)
AGENT_TYPE=$(echo "$INPUT" | jq -r '.agent_type // empty')
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# Only enforce within known agent contexts
if [ -z "$AGENT_TYPE" ] || [ -z "$FILE_PATH" ]; then
  exit 0
fi

FILENAME=$(basename "$FILE_PATH")
DIR_PATH=$(dirname "$FILE_PATH")

# Detect if file is a test file (by name patterns and directory conventions)
is_test_file() {
  local f="$1"
  local d="$2"
  # Name patterns
  case "$f" in
    *.test.*|*.spec.*|*.tests.*|*.specs.*) return 0 ;;
    test_*|*_test.*) return 0 ;;
  esac
  # Directory patterns
  case "$d" in
    */__tests__/*|*/tests/*|*/test/*|*/__mocks__/*|*/__fixtures__/*) return 0 ;;
    */test_*|*/fixtures/*|*/testutils/*|*/test-utils/*) return 0 ;;
  esac
  # Config files that are test-specific
  case "$f" in
    jest.config.*|vitest.config.*|pytest.ini|.pytest.ini|conftest.py|setup.cfg) return 0 ;;
    karma.conf.*|.nycrc|.nycrc.json|cypress.config.*|playwright.config.*) return 0 ;;
  esac
  return 1
}

# DEVELOPER trying to edit a test file → BLOCK
if [ "$AGENT_TYPE" = "developer" ]; then
  if is_test_file "$FILENAME" "$DIR_PATH"; then
    echo "IRON RULE VIOLATION: Developer attempted to edit test file: $FILE_PATH" >&2
    echo "Tests are the tester's exclusive domain. Report the issue to CEO instead." >&2
    exit 2
  fi
fi

# TESTER trying to edit a non-test file → BLOCK
if [ "$AGENT_TYPE" = "tester" ]; then
  if ! is_test_file "$FILENAME" "$DIR_PATH"; then
    echo "IRON RULE VIOLATION: Tester attempted to edit production file: $FILE_PATH" >&2
    echo "Production code is the developer's exclusive domain. Report the issue to CEO instead." >&2
    exit 2
  fi
fi

exit 0
