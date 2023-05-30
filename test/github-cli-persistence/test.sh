#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# check that `gh --help` works
check "help" gh --help 2>&1 >/dev/null | grep 'USAGE'

# check that `.config/gh` and `/dc/github-cli` exist
check "config" ls -la "$_REMOTE_USER_HOME/.config" | grep "gh"
check "dc" ls -la /dc | grep 'github-cli'


# Report result
reportResults
