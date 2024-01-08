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
check "config" bash -c "ls -la ~/.config | grep 'gcloud'"
check "dc" bash -c "ls -la /dc | grep 'gcloud-cli'"

# check that `~/.config/gcloud` is a symlink
# https://unix.stackexchange.com/a/96910
check "~/.config/gcloud is a symlink" bash -c "test -L ~/.config/gcloud && test -d ~/.config/gcloud"

# Report result
reportResults
