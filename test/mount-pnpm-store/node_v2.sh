#!/bin/bash

set -e

# Regression test for the pnpm >= 9 global bin dir check (issue #80):
# node feature v2 installs latest pnpm by default, which made the
# unpatched oncreate.sh fail the container build with
# "The configured global bin directory ... is not in PATH".
# Reaching this script at all proves onCreateCommand survived.

# The test shell is non-interactive too, so it needs the same env
# the patched oncreate.sh provides for itself.
export PNPM_HOME="${PNPM_HOME:-$HOME/.local/share/pnpm}"
export PATH="$PNPM_HOME/bin:$PATH"

./_default.sh
