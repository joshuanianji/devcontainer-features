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
# https://askubuntu.com/a/175060
echo "Checking ownership of ~/.terraform.d and /dc/terraform-cli (ensure it is owned by $USER)"

check "~/.terraform.d owned by user" bash -c "test \"$(stat -c "%U" ~/.terraform.d)\" = $USER"
check "/dc/terraform-cli owned by user" bash -c "test \"$(stat -c "%U" /dc/terraform-cli)\" = $USER"

# Report result
reportResults
