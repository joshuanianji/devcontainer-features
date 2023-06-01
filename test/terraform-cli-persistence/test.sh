#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# NOTE: terraform is not installed inside the `test.sh` run
# see: test/github-cli-persistence/test.sh


# check that `~/.terraform.d` and `/dc/terraform-cli` exist`
check "~/.terraform.d existence" bash -c "ls -la ~ | grep '.terraform.d'"
check "/dc/terraform-cli existence" bash -c "ls -la /dc | grep 'terraform-cli'"

# check that `~/.terraform.d` is a symlink
# https://unix.stackexchange.com/a/96910
check "~/.terraform.d is a symlink" bash -c "test -L ~/.terraform.d && test -d ~/.terraform.d"

# Report result
reportResults
