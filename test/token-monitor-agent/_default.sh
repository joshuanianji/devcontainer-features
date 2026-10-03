#!/bin/bash

set -e

# This is the default test script that tests everything
# It is not run as a scenario, but is run by other test scripts.

# Optional: Import test library
source dev-container-features-test-lib

# state volume mounted at the right target and usable by the current user
check "/dc/token-monitor/state exists" test -d /dc/token-monitor/state
if [ "$(id -u)" = "0" ]; then
    check "/dc/token-monitor/state writable" test -w /dc/token-monitor/state
else
    check "/dc/token-monitor/state owned by user" test "$(stat -c '%U' /dc/token-monitor/state)" = "$(id -un)"
fi

# the launcher is installed and runnable
check "start.sh installed" test -x /usr/local/share/token-monitor-agent/scripts/start.sh

# without a configured secret it must exit 0 and stay silent (never break startup)
check "silent without secret" bash -c "/usr/local/share/token-monitor-agent/scripts/start.sh | grep 'staying silent'"

# reportResults
reportResults
