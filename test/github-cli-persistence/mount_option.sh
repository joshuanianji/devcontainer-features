#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

cat ~/.bashrc

# check that MOUNT_NAME is set
echo "Mount is $MOUNT"
check "MOUNT env is set" bash -c "test ! -z \"$MOUNT\""

# Report result
reportResults
