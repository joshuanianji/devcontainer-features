#!/bin/bash

set -e

# This is the default test script that tests everything
# It is not run as a scenario, but is run by other test scripts.

# Optional: Import test library
source dev-container-features-test-lib

# check that the shared volume is mounted at the right target
check "/dc/claude exists" test -d /dc/claude

# check that the current user can use it. The volume is SHARED across scenarios,
# so a previous run may have chowned it to a different user - for root, the
# guarantee is writability; for regular users, ownership.
if [ "$(id -u)" = "0" ]; then
    check "/dc/claude writable" test -w /dc/claude
else
    check "/dc/claude owned by user" test "$(stat -c '%U' /dc/claude)" = "$(id -un)"
fi

# check that the feature's containerEnv is applied to the container
check "CLAUDE_CONFIG_DIR set by containerEnv" test "$CLAUDE_CONFIG_DIR" = "/dc/claude"

# check the /etc/profile.d fallback for login shells
check "CLAUDE_CONFIG_DIR in profile.d" bash -lc 'test "$CLAUDE_CONFIG_DIR" = "/dc/claude"'

# write-through: files land in the volume (what makes them survive rebuilds)
check "write-through" bash -c "echo persistence > /dc/claude/.persistence-check && grep persistence /dc/claude/.persistence-check"

# Report result
reportResults
