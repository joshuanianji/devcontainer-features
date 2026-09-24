#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# check that `gcloud --version` works
check "gcloud --version" bash -c "gcloud --version | grep 'Google Cloud SDK'"

# check the gke-gcloud-auth-plugin package is installed via apt
check "gke-gcloud-auth-plugin installed" bash -c "dpkg -s google-cloud-cli-gke-gcloud-auth-plugin"

# check the plugin binary is actually usable, not just unpacked
check "gke-gcloud-auth-plugin on PATH" bash -c "command -v gke-gcloud-auth-plugin"
check "gke-gcloud-auth-plugin --version" bash -c "gke-gcloud-auth-plugin --version"

# Report result
reportResults
