#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# check that `gcloud --help` works
check "help" bash -c "gcloud --help | grep 'NAME'"

# check that `.config/gcloud` and `/dc/gcloud-cli` exist under the user (should be node)
check "config" bash -c "ls -la ~/.config | grep 'gcloud'"
check "dc" bash -c "ls -la /dc | grep 'gcloud-cli'"

# check that the folders are owned by the user
# `stat -c "%U %G" ~/.config` returns "$USER $GROUP", in this case "node node"
# https://askubuntu.com/a/175060
check "~/.config/gloud owned by user" bash -c "test \"$(stat -c "%U %G" ~/.config/gcloud)\" = 'node node'"
check "/dc/gcloud-cli owned by user" bash -c "test \"$(stat -c "%U %G" /dc/gcloud-cli)\" = 'node node'"

# Report result
reportResults
