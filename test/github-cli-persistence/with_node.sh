#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# check that `gh --help` works
check "help" bash -c "gh --help | grep 'USAGE'"

# check that `.config/gh` and `/dc/github-cli` exist under the user (should be node)
check "config" bash -c "ls -la ~/.config | grep 'gh'"
check "dc" bash -c "ls -la /dc | grep 'github-cli'"

# TODO: check that ~/.config/gh is owned by the current user

# Report result
reportResults
