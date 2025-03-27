#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# NOTE: this is an "auto-generated" test, which means it will be
# executed against an auto-generated devcontainer.json that
# includes the feature with no options

./_default.sh
