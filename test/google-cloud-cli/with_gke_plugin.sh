#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# check that `gcloud --version` works
check "gcloud --version" bash -c "gcloud --version | grep 'Google Cloud SDK'"

# check the gke-gcloud-auth-plugin package is installed via apt
check "gke-gcloud-auth-plugin installed" bash -c "dpkg -s google-cloud-sdk-gke-gcloud-auth-plugin"

# Report result
reportResults
