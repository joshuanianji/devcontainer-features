#!/bin/bash

set -e

# This is the default test script that tests everything
# It is not run as a scenario, but is run by other test scripts.

# Optional: Import test library
source dev-container-features-test-lib

# check that `gh --help` works
check "help" bash -c "gh --help | grep 'USAGE'"

# check that `.config/gh` and `/dc/github-cli` exist under the user (should be node)
check "config" bash -c "ls -la ~/.config | grep 'gh'"
check "dc" bash -c "ls -la /dc | grep 'github-cli'"

# check that the folders are owned by the user
# https://askubuntu.com/a/175060
echo "Checking ownership of ~/.config/gh and /dc/github-cli (ensure it is owned by $USER)"

check "~/.config/gh owned by user" bash -c "test \"$(stat -c "%U" ~/.config/gh)\" = $USER"
check "/dc/github-cli owned by user" bash -c "test \"$(stat -c "%U" /dc/github-cli)\" = $USER"

# Report result
reportResults
