#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

echo "PNPM Store Path: $PNPM_STORE_PATH"

# check that `pnpm config get store-dir` equals /home/node/.pnpm-store
pnpmConfig=$(pnpm config get store-dir)
echo "pnpm config get store-dir: $pnpmConfig"
check "config" bash -c test "$pnpmConfig" = "/home/node/.pnpm-store"

# Report result
reportResults
