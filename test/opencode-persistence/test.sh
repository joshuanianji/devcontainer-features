#!/bin/bash

set -e

source dev-container-features-test-lib

# NOTE: this is an "auto-generated" test, which runs against a devcontainer.json
# containing only the 'opencode-persistence' feature (no opencode CLI install).
# https://github.com/devcontainers/cli/blob/main/docs/features/test.md

check "/dc/opencode/data exists" test -d /dc/opencode/data
check "/dc/opencode/config exists" test -d /dc/opencode/config
if [ "$(id -u)" = "0" ]; then
    check "/dc/opencode/data writable" test -w /dc/opencode/data
    check "/dc/opencode/config writable" test -w /dc/opencode/config
else
    check "/dc/opencode/data owned by user" test "$(stat -c '%U' /dc/opencode/data)" = "$(id -un)"
    check "/dc/opencode/config owned by user" test "$(stat -c '%U' /dc/opencode/config)" = "$(id -un)"
fi
check "~/.local/share/opencode is symlink" bash -c "test -L ~/.local/share/opencode && test -d ~/.local/share/opencode"
check "~/.config/opencode is symlink" bash -c "test -L ~/.config/opencode && test -d ~/.config/opencode"
check "symlink targets" bash -c "test \"$(readlink ~/.local/share/opencode)\" = /dc/opencode/data && test \"$(readlink ~/.config/opencode)\" = /dc/opencode/config"
check "write-through via symlink" bash -c "echo persistence > ~/.local/share/opencode/.persistence-check && grep persistence /dc/opencode/data/.persistence-check"

# Report result
reportResults
