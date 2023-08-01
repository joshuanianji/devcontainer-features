#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# NOTE: this is an "auto-generated" test, which means it will be 
# executed against an auto-generated devcontainer.json that
# includes the 'lamdera' Feature with no options.
#
# https://github.com/devcontainers/cli/blob/main/docs/features/test.md
#

# check that running the binary by itself works
check "normal" bash -c "lamdera"

# check version
check "version" bash -c "lamdera --version"

# Report result
reportResults
