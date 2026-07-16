#!/bin/bash

set -e

# Default test script that tests everything.
# It is not run as a scenario on its own, but is invoked by the per-scenario
# scripts.

# Optional: Import test library
source dev-container-features-test-lib

# check that `gcloud --version` works and reports the SDK name
check "gcloud --version" bash -c "gcloud --version | grep 'Google Cloud SDK'"

# check the binary is on PATH for the remote user
check "gcloud on PATH" bash -c "command -v gcloud"

# Report result
reportResults
