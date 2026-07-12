#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Auto-generated test: runs against the bare feature with no other features
# installed, so we just check that gcloud is on PATH and reports its version.

check "gcloud on PATH" bash -c "command -v gcloud"
check "gcloud --version" bash -c "gcloud --version | grep 'Google Cloud SDK'"

# Report result
reportResults
