#!/bin/bash

set -e

# This is the default test script that tests everything
# It is not run as a scenario, but is run by other test scripts.

# Optional: Import test library
source dev-container-features-test-lib

# check that the shared volumes are mounted at the right targets
check "/dc/opencode/data exists" test -d /dc/opencode/data
check "/dc/opencode/config exists" test -d /dc/opencode/config

# check that the current user can use them. The volumes are SHARED across
# scenarios, so a previous run may have chowned them to a different user - for
# root, the guarantee is writability; for regular users, ownership.
if [ "$(id -u)" = "0" ]; then
    check "/dc/opencode/data writable" test -w /dc/opencode/data
    check "/dc/opencode/config writable" test -w /dc/opencode/config
else
    check "/dc/opencode/data owned by user" test "$(stat -c '%U' /dc/opencode/data)" = "$(id -un)"
    check "/dc/opencode/config owned by user" test "$(stat -c '%U' /dc/opencode/config)" = "$(id -un)"
fi

# check that the XDG dirs are symlinks into the volumes
check "~/.local/share/opencode is symlink" bash -c "test -L ~/.local/share/opencode && test -d ~/.local/share/opencode"
check "~/.config/opencode is symlink" bash -c "test -L ~/.config/opencode && test -d ~/.config/opencode"

# check the symlink targets
check "symlink targets" bash -c "test \"$(readlink ~/.local/share/opencode)\" = /dc/opencode/data && test \"$(readlink ~/.config/opencode)\" = /dc/opencode/config"

# write-through: a file written via the symlink appears in the volume
check "write-through via symlink" bash -c "echo persistence > ~/.local/share/opencode/.persistence-check && grep persistence /dc/opencode/data/.persistence-check"

# Report result
reportResults
