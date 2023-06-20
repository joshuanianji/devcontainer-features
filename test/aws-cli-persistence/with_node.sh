#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# check that `aws --help` works
check "help" bash -c "aws help | grep 'usage'"

# check that `.aws` and `/dc/aws-cli` exist under the user (should be node)
check "~/.aws existence" bash -c "ls -la ~ | grep '.aws'"
check "/dc/aws-cli existence" bash -c "ls -la /dc | grep 'aws-cli'"

# check that the folders are owned by the user
# `stat -c "%U %G" ~/.aws` returns "$USER $GROUP", in this case "node node"
# https://askubuntu.com/a/175060
check "~/.aws owned by user" bash -c "test \"$(stat -c "%U %G" ~/.aws)\" = 'node node'"
check "/dc/aws-cli owned by user" bash -c "test \"$(stat -c "%U %G" /dc/aws-cli)\" = 'node node'"

# Report result
reportResults
