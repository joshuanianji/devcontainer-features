#!/bin/bash

set -e

# Default test script that tests everything
# It is not run as a scenario, but is run by other test scripts.

# Optional: Import test library
source dev-container-features-test-lib

# user is `node` in dev container

echo "User: $(whoami)"
pnpm config list

# check that `pnpm config get store-dir` equals ~/.pnpm-store
pnpmConfig=$(pnpm config get store-dir)
echo "pnpm config get store-dir: '$pnpmConfig'"
check "config" test $pnpmConfig = "$(echo ~)/.pnpm-store"

# Report result
reportResults
