#!/bin/sh

set -e

# ensure the state dir is owned by the remote user, but never block container
# creation over it
if [ "$(id -u)" != "0" ]; then
    if [ "$(stat -c '%u' /dc/token-monitor/state 2>/dev/null)" = "$(id -u)" ]; then
        echo "/dc/token-monitor/state already owned by $(id -un); skipping chown"
    elif command -v sudo >/dev/null 2>&1; then
        sudo -n chown -R "$(id -un):$(id -un)" /dc/token-monitor/state \
            || echo "WARN: could not chown /dc/token-monitor/state as $(id -un)"
    else
        echo "WARN: sudo unavailable and /dc/token-monitor/state not owned by $(id -un)"
    fi
fi
