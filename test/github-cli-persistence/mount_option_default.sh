#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

cat ~/.bashrc

# check that MOUNT_NAME is set
echo "Mount is $MOUNT"
check "MOUNT env is set" bash -c "test ! -z \"$MOUNT\""

# check that /dc/github-cli is a folder
check "MOUNT is a folder" bash -c "test -d /dc/github-cli"

# check that /dc/custom-mount if a folder
check "CUSTOM_MOUNT is a folder" bash -c "test -d /dc/custom-mount"

# check how many files are in /dc/github-cli and cat `hosts.yml`
ls -al /dc/github-cli 
cat /dc/github-cli/hosts.yml

# Report result
reportResults
