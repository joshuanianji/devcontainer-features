#!/bin/bash

set -e

# Default test script that tests everything.
# It is not run as a scenario on its own, but is invoked by the per-scenario
# scripts.

# Optional: Import test library
source dev-container-features-test-lib

echo "User: $(whoami)"
pnpm config list

# check that `pnpm config get store-dir` equals the mounted volume path.
# `NPM_CONFIG_STORE_DIR` from containerEnv is what populates this; the
# feature itself never invokes pnpm.
pnpmConfig=$(pnpm config get store-dir)
echo "pnpm config get store-dir: '$pnpmConfig'"
check "store-dir points at mounted volume" bash -c "test \"$pnpmConfig\" = '/dc/mounted-pnpm-store'"

# check that `/dc/mounted-pnpm-store` exists and is owned by the user
echo "Checking ownership of /dc/mounted-pnpm-store (ensure it is owned by $USER)"
check "/dc/mounted-pnpm-store owned by user" bash -c "test \"$(stat -c "%U" /dc/mounted-pnpm-store)\" = $USER"

# Report result
reportResults
