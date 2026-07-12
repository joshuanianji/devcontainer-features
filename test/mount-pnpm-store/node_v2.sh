#!/bin/bash

set -e

# Regression test for the pnpm >= 9 global bin dir check (issue #80):
# in v1.0.x, `oncreate.sh` ran `pnpm config set --global` in a non-interactive
# shell where pnpm's global bin dir wasn't on PATH, so it failed the container
# build. v1.1.0 removed the pnpm invocation entirely; reaching this script at
# all proves onCreateCommand survived.
#
# The test shell is non-interactive too, so it still needs PNPM_HOME in PATH
# for `pnpm config get store-dir` (in _default.sh) to find the pnpm binary —
# independent of the feature itself.
export PNPM_HOME="${PNPM_HOME:-$HOME/.local/share/pnpm}"
export PATH="$PNPM_HOME/bin:$PATH"

./_default.sh
