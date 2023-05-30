#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# check that `gh --help` works
check "help" bash -c "gh --help | grep 'USAGE'"

# check that `.config/gh` and `/dc/github-cli` exist under the user (should be node)
check "config" bash -c "ls -la ~/.config | grep 'gh'"
check "dc" bash -c "ls -la /dc | grep 'github-cli'"

# check that the folders are owned by the user
# `stat -c "%U %G" ~/.config` returns "$USER $GROUP", in this case "node node"
# https://askubuntu.com/a/175060
check "~/.config/gh owned by user" bash -c "if [[ \"$(stat -c "%U %G" ~/.config)\" != 'node node' ]]; then exit 1; fi;"
check "/dc/github-cli owned by user" bash -c "if [[ \"$(stat -c "%U %G" /dc/github-cli)\" != 'node node' ]]; then exit 1; fi;"

# Report result
reportResults
