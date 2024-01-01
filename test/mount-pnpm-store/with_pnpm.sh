#!/bin/bash

set -e

# tests installing pnpm with a feature

# Optional: Import test library
source dev-container-features-test-lib

echo "User: $(whoami)"
pnpm config list

# check that `pnpm config get store-dir` returns /home/node/.pnpm-store
pnpmConfig=$(pnpm config get store-dir)
echo "pnpm config get store-dir: $pnpmConfig"
check "config" bash -c test $pnpmConfig -eq "/home/vscode/.pnpm-store"

# Report result
reportResults
