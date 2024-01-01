#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# NOTE: this is an "auto-generated" test, which means it will be 
# executed against an auto-generated devcontainer.json that
# includes the 'mount-pnpm-store' feature with no options.
#
# https://github.com/devcontainers/cli/blob/main/docs/features/test.md
#
# From my tests, this means the `pnpm` CLI will not be installed

# check that `~/.pnpm-store` and `/dc/mounted-pnpm-store` exist`
check "config" bash -c "ls -la ~ | grep '.pnpm-store'"
check "dc" bash -c "ls -la /dc | grep 'mounted-pnpm-store'"

# check that `~/.pnpm-store` is a symlink
# https://unix.stackexchange.com/a/96910
check "~/.pnpm-store is a symlink" bash -c "test -L ~/.pnpm-store && test -d ~/.pnpm-store"

# Report result
reportResults
