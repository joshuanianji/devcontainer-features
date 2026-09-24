#!/bin/sh

set -e

# ensure the opencode volumes are owned by the remote user, but never block
# container creation over it: fresh volumes usually already inherit the right
# owner (docker copy-on-first-use from the image, which install.sh chowned)
if [ "$(id -u)" != "0" ]; then
    for dir in /dc/opencode/data /dc/opencode/config; do
        if [ "$(stat -c '%u' "$dir" 2>/dev/null)" = "$(id -u)" ]; then
            echo "$dir already owned by $(id -un); skipping chown"
        elif command -v sudo >/dev/null 2>&1; then
            sudo -n chown -R "$(id -un):$(id -un)" "$dir" \
                || echo "WARN: could not chown $dir as $(id -un)"
        else
            echo "WARN: sudo unavailable and $dir not owned by $(id -un)"
        fi
    done
fi
