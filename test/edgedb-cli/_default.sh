#!/bin/bash

set -e

# This is the default test script that tests everything
# It is not run as a scenario, but is run by other test scripts.

# Optional: Import test library
source dev-container-features-test-lib

# check that the command is available
check "help" bash -c "edgedb --help | grep 'Usage'"

# check that `.config/gh` and `/dc/github-cli` exist under the user (should be node)
check "~/.local/share/edgedb exists" bash -c "ls -la ~/.local/share | grep 'edgedb'"
check "/dc/edgedb-cli exists" bash -c "ls -la /dc | grep 'edgedb-cli'"

# check that the folders are owned by the user
# https://askubuntu.com/a/175060
echo "Checking ownership of ~/.local/share/edgedb and /dc/edgedb-cli (ensure it is owned by $USER)"
ls -al ~/.local/share/

check "~/.local/share/edgedb owned by user" bash -c "test \"$(stat -c "%U" ~/.local/share/edgedb)\" = $USER"
check "/dc/edgedb-cli owned by user" bash -c "test \"$(stat -c "%U" /dc/edgedb-cli)\" = $USER"

# Report result
reportResults
