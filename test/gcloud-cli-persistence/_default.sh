#!/bin/bash

set -e

# This is the default test script that tests everything
# It is not run as a scenario, but is run by other test scripts.

# Optional: Import test library
source dev-container-features-test-lib

# check that `gcloud --help` works
check "help" bash -c "gcloud --help | grep 'NAME'"

# check that `.config/gcloud` and `/dc/gcloud-cli` exist under the user (should be node)
check "config" bash -c "ls -la ~/.config | grep 'gcloud'"
check "dc" bash -c "ls -la /dc | grep 'gcloud-cli'"

# check that the folders are owned by the user
# https://askubuntu.com/a/175060
echo "Checking ownership of ~/.config/gcloud and /dc/gcloud-cli (ensure it is owned by $USER)"
stat -c "%U" /dc/gcloud-cli

check "~/.config/gloud owned by user" bash -c "test \"$(stat -c "%U" ~/.config/gcloud)\" = $USER"
check "/dc/gcloud-cli owned by user" bash -c "test \"$(stat -c "%U" /dc/gcloud-cli)\" = $USER"

# Report result
reportResults
