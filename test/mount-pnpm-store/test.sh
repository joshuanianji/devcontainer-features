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
# From our tests, this means the `pnpm` CLI will not be installed,
# so we only verify the mount point and the env var (no pnpm call).

# check that `/dc/mounted-pnpm-store` exists
check "dc" bash -c "ls -la /dc | grep 'mounted-pnpm-store'"

# check the containerEnv var is set (this is what actually relocates the store)
check "NPM_CONFIG_STORE_DIR" bash -c "test \"$NPM_CONFIG_STORE_DIR\" = '/dc/mounted-pnpm-store'"

# Report result
reportResults
