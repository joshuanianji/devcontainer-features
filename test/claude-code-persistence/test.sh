#!/bin/bash

set -e

source dev-container-features-test-lib

# NOTE: this is an "auto-generated" test, which runs against a devcontainer.json
# containing only the 'claude-code-persistence' feature (no claude CLI install).
# https://github.com/devcontainers/cli/blob/main/docs/features/test.md

check "/dc/claude exists" test -d /dc/claude
if [ "$(id -u)" = "0" ]; then
    check "/dc/claude writable" test -w /dc/claude
else
    check "/dc/claude owned by user" test "$(stat -c '%U' /dc/claude)" = "$(id -un)"
fi
check "CLAUDE_CONFIG_DIR set by containerEnv" test "$CLAUDE_CONFIG_DIR" = "/dc/claude"
check "CLAUDE_CONFIG_DIR in profile.d" bash -lc 'test "$CLAUDE_CONFIG_DIR" = "/dc/claude"'
check "write-through" bash -c "echo persistence > /dc/claude/.persistence-check && grep persistence /dc/claude/.persistence-check"

# Report result
reportResults
