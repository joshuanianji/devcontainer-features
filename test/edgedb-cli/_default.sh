#!/bin/bash

set -e

# This is the default test script that tests everything
# It is not run as a scenario, but is run by other test scripts.

# Optional: Import test library
source dev-container-features-test-lib

# check that the command is available
check "help" bash -c "edgedb --help | grep 'Usage'"

# check that data directories exist
check "~/.local/share/edgedb exists" bash -c "ls -la ~/.local/share | grep 'edgedb'"
check "/dc/edgedb-cli/data exists" bash -c "ls -la /dc/edgedb-cli | grep 'data'"

# check that config directories exist
check "~/.config/edgedb exists" bash -c "ls -la ~/.config | grep 'edgedb'"
check "/dc/edgedb-cli exists" bash -c "ls -la /dc/edgedb-cli | grep 'config'"

# check that the folders are owned by the user
# https://askubuntu.com/a/175060
echo "Checking ownership of ~/.local/share/edgedb/data and /dc/edgedb-cli/data (ensure it is owned by $USER)"

check "~/.local/share/edgedb owned by user" bash -c "test \"$(stat -c "%U" ~/.local/share/edgedb)\" = $USER"
check "/dc/edgedb-cli/data owned by user" bash -c "test \"$(stat -c "%U" /dc/edgedb-cli/data)\" = $USER"

check "~/.config/edgedb owned by user" bash -c "test \"$(stat -c "%U" ~/.config/edgedb)\" = $USER"
check "/dc/edgedb-cli/config owned by user" bash -c "test \"$(stat -c "%U" /dc/edgedb-cli/config)\" = $USER"

# Report result
reportResults
