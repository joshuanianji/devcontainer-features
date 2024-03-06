#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# NOTE: this is an "auto-generated" test, which means it will be
# executed against an auto-generated devcontainer.json that
# includes the 'gcloud-cli-persistence' Feature with no options.
#
# https://github.com/devcontainers/cli/blob/main/docs/features/test.md
#
# From my tests, this means the `gcloud` CLI will not be installed:
# Thus, here, I only check basic directory existence

# check that `~/.config/gcloud` and `/dc/gcloud-cli` exist`
check "config" bash -c "ls -la ~/.local/share/ | grep 'edgedb'"
check "dc" bash -c "ls -la /dc | grep 'edgedb-cli'"

# check that `~/.config/gcloud` is a symlink
# https://unix.stackexchange.com/a/96910
check "~/.local/share/edgedb is a symlink" bash -c "test -L ~/.local/share/edgedb && test -d ~/.local/share/edgedb"

# Report result
reportResults
