#!/bin/bash

set -e

# Default test script that tests everything
# It is not run as a scenario, but is run by other test scripts.

# Optional: Import test library
source dev-container-features-test-lib

# check that `terraform --help` works
check "help" bash -c "terraform --help | grep 'Usage'"

# check that `.terraform.d` and `/dc/terraform-cli` exist under the user (should be node)
check "~/.terraform.d existence" bash -c "ls -la ~ | grep '.terraform.d'"
check "/dc/terraform-cli existence" bash -c "ls -la /dc | grep 'terraform-cli'"

# check that the folders are owned by the user
# `stat -c "%U %G" ~/.terraform.d` returns "$USER $GROUP", in this case "node node"
# https://askubuntu.com/a/175060
check "~/.terraform.d owned by user" bash -c "test \"$(stat -c "%U %G" ~/.terraform.d)\" = 'node node'"
check "/dc/terraform-cli owned by user" bash -c "test \"$(stat -c "%U %G" /dc/terraform-cli)\" = 'node node'"

# Report result
reportResults
