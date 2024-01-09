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

# check that the folders are owned by the user
# https://askubuntu.com/a/175060
echo "Checking ownership of /dc/mounted-pnpm-store (ensure it is owned by $USER)"

check "/dc/mounted-pnpm-store owned by user" bash -c "test \"$(stat -c "%U" /dc/mounted-pnpm-store)\" = $USER"

# Report result
reportResults
