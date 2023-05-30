#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# NOTE: this is an "auto-generated" test, which means it will be 
# executed against an auto-generated devcontainer.json that
# includes the 'github-cli-persistence' Feature with no options.
#
# https://github.com/devcontainers/cli/blob/main/docs/features/test.md
#
# From my tests, this means the `gh` CLI will not be installed:
# Thus, here, I only check basic directory existence


# check that `~/.config/gh` and `/dc/github-cli` exist`
check "config" bash -c "ls -la ~/.config | grep 'gh'"
check "dc" bash -c "ls -la /dc | grep 'github-cli'"

# check that `~/.config/gh` is a symlink
# https://unix.stackexchange.com/a/96910
check "~/.config/gh is a symlink" bash -c "test -L ~/.config/gh && test -d ~/.config/gh"

# Report result
reportResults
