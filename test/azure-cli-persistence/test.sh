#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# NOTE: azure is not installed inside the `test.sh` run
# see: test/github-cli-persistence/test.sh


# check that `~/.azure` and `/dc/azure-cli` exist`
check "~/.azure existence" bash -c "ls -la ~ | grep '.azure'"
check "/dc/azure-cli existence" bash -c "ls -la /dc | grep 'azure-cli'"

# check that `~/.azure` is a symlink
# https://unix.stackexchange.com/a/96910
check "~/.azure is a symlink" bash -c "test -L ~/.azure && test -d ~/.azure"

# Report result
reportResults
