#!/bin/bash

set -e

# tests installing pnpm mount when pnpm is already installed in the base image

# Optional: Import test library
source dev-container-features-test-lib

# user is `node` in dev container

echo "User: $(whoami)"
pnpm config list

# check that `pnpm config get store-dir` equals /home/node/.pnpm-store
pnpmConfig=$(pnpm config get store-dir)
echo "pnpm config get store-dir: $pnpmConfig"
check "config" bash -c test $pnpmConfig -eq "/home/node/.pnpm-store"

# Report result
reportResults
