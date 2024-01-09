#!/bin/bash

set -e

# This script is the "default" test script for the aws-cli-persistence feature.
# It is not run as a scenario, but is run by other test scripts.

# Optional: Import test library
source dev-container-features-test-lib

# check that `aws --help` works
check "help" bash -c "aws help | grep 'usage'"

# check that `.aws` and `/dc/aws-cli` exist under the user (should be node)
check "~/.aws existence" bash -c "ls -la ~ | grep '.aws'"
check "/dc/aws-cli existence" bash -c "ls -la /dc | grep 'aws-cli'"

# check that the folders are owned by the user
# https://askubuntu.com/a/175060
echo "Checking ownership of ~/.aws and /dc/aws-cli (ensure it is owned by $USER)"
stat -c "%U" /dc/aws-cli

check "~/.aws owned by user" bash -c "test \"$(stat -c "%U" ~/.aws)\" = \"$USER\""
check "/dc/aws-cli owned by user" bash -c "test \"$(stat -c "%U" /dc/aws-cli)\" = \"$USER\""

# Report result
reportResults
