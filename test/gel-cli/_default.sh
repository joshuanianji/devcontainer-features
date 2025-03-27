#!/bin/bash

set -e

# This is the default test script that tests everything
# It is not run as a scenario, but is run by other test scripts.

# Optional: Import test library
source dev-container-features-test-lib

# check that the command is available
check "help" bash -c "gel --help | grep 'Usage'"

# make sure gel directories match up with our expectations
check "gel cli data dir" bash -c "test \"$(gel info --get data-dir)\" = $HOME/.local/share/gel/data/"
check "gel cli config dir" bash -c "test \"$(gel info --get config-dir)\" = $HOME/.config/gel/"

# check that data directories exist
check "~/.local/share/gel exists" bash -c "ls -la ~/.local/share | grep 'gel'"
check "/dc/gel-cli/data exists" bash -c "ls -la /dc/gel-cli | grep 'data'"

# check that config directories exist
check "~/.config/gel exists" bash -c "ls -la ~/.config | grep 'gel'"
check "/dc/gel-cli exists" bash -c "ls -la /dc/gel-cli | grep 'config'"

# check that the folders are owned by the user
# https://askubuntu.com/a/175060
# $USER is empty when running as root, so we use $(whoami)
echo "Checking ownership of ~/.local/share/gel/data and /dc/gel-cli/data (ensure it is owned by $(whoami))"

check "~/.local/share/gel owned by user" bash -c "test \"$(stat -c "%U" ~/.local/share/gel)\" = $(whoami)"
check "/dc/gel-cli/data owned by user" bash -c "test \"$(stat -c "%U" /dc/gel-cli/data)\" = $(whoami)"

check "~/.config/gel owned by user" bash -c "test \"$(stat -c "%U" ~/.config/gel)\" = $(whoami)"
check "/dc/gel-cli/config owned by user" bash -c "test \"$(stat -c "%U" /dc/gel-cli/config)\" = $(whoami)"

# Report result
reportResults
