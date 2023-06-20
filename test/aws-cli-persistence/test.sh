#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# NOTE: aws is not installed inside the `test.sh` run
# see: test/github-cli-persistence/test.sh


# check that `~/.aws` and `/dc/aws-cli` exist`
check "~/.aws existence" bash -c "ls -la ~ | grep '.aws'"
check "/dc/aws-cli existence" bash -c "ls -la /dc | grep 'aws-cli'"

# check that `~/.aws` is a symlink
# https://unix.stackexchange.com/a/96910
check "~/.aws is a symlink" bash -c "test -L ~/.aws && test -d ~/.aws"

# Report result
reportResults
