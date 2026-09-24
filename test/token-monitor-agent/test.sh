#!/bin/bash

set -e

source dev-container-features-test-lib

check "/dc/token-monitor/state exists" test -d /dc/token-monitor/state
check "start.sh installed" test -x /usr/local/share/token-monitor-agent/scripts/start.sh
check "silent without secret" bash -c "/usr/local/share/token-monitor-agent/scripts/start.sh | grep 'staying silent'"

# Report result
reportResults
