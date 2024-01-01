#!/bin/bash

set -e

# User is `vscode` in dev container

# Optional: Import test library
source dev-container-features-test-lib

echo "User: $(whoami)"
ls -al /home/vscode

echo "PNPM Store Path: $PNPM_STORE_PATH"

# check that `pnpm config get store-dir` returns /home/node/.pnpm-store
pnpmConfig=$(pnpm config get store-dir)
echo "pnpm config get store-dir: $pnpmConfig"
check "config" bash -c test "$pnpmConfig" = "/home/vscode/.pnpm-store"

# Report result
reportResults
