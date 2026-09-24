#!/bin/sh

set -e

# ensure /dc/claude is owned by the remote user, but never block container
# creation over it: fresh volumes usually already inherit the right owner
# (docker copy-on-first-use from the image, which install.sh chowned)
if [ "$(id -u)" != "0" ]; then
    if [ "$(stat -c '%u' /dc/claude 2>/dev/null)" = "$(id -u)" ]; then
        echo "/dc/claude already owned by $(id -un); skipping chown"
    elif command -v sudo >/dev/null 2>&1; then
        sudo -n chown -R "$(id -un):$(id -un)" /dc/claude \
            || echo "WARN: could not chown /dc/claude as $(id -un)"
    else
        echo "WARN: sudo unavailable and /dc/claude not owned by $(id -un)"
    fi
fi
