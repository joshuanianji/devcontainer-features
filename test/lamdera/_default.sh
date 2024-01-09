#!/bin/bash

set -e

# This is the default test script that tests everything
# It is not run as a scenario, but is run by other test scripts.

# Optional: Import test library
source dev-container-features-test-lib

# check that running the binary by itself works
check "normal" bash -c "lamdera"

# check version
check "version" bash -c "lamdera --version"

# Report result
reportResults
