#!/bin/sh

set -e

# ensure /dc/github-cli is owned by the remote user, but never block container
# creation over it. $USER isn't reliably set in lifecycle commands, so use id.
if [ "$(id -u)" != "0" ]; then
    USERNAME="$(id -un)"
    if [ "$(stat -c '%u' /dc/github-cli 2>/dev/null)" = "$(id -u)" ]; then
        echo "/dc/github-cli already owned by ${USERNAME}; skipping chown"
    elif command -v sudo >/dev/null 2>&1; then
        echo "Running oncreate.sh for user ${USERNAME}"
        sudo -n chown -R "${USERNAME}:${USERNAME}" /dc/github-cli \
            || echo "WARN: could not chown /dc/github-cli as ${USERNAME}"
    else
        echo "WARN: sudo unavailable and /dc/github-cli not owned by ${USERNAME}"
    fi
fi
