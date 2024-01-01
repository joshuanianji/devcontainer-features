#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# check that running the binary by itself works
check "normal" bash -c "lamdera"

# check version
check "version" bash -c "lamdera --version"

# Report result
reportResults
