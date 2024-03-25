#!/bin/bash

set -e

# This script is the "default" test script for the azure-cli-persistence feature.
# It is not run as a scenario, but is run by other test scripts.

# Optional: Import test library
source dev-container-features-test-lib

# check that `azure --help` works
check "help" bash -c "azure help | grep 'usage'"

# check that `.azure` and `/dc/azure-cli` exist under the user (should be node)
check "~/.azure existence" bash -c "ls -la ~ | grep '.azure'"
check "/dc/azure-cli existence" bash -c "ls -la /dc | grep 'azure-cli'"

# check that the folders are owned by the user
# https://askubuntu.com/a/175060
echo "Checking ownership of ~/.azure and /dc/azure-cli (ensure it is owned by $USER)"

check "~/.azure owned by user" bash -c "test \"$(stat -c "%U" ~/.azure)\" = $USER"
check "/dc/azure-cli owned by user" bash -c "test \"$(stat -c "%U" /dc/azure-cli)\" = $USER"

# Report result
reportResults
