#!/bin/sh

set -e

STORE_DIR="/dc/mounted-pnpm-store"

# The shared named volume is mounted over STORE_DIR at runtime, so build-time
# ownership only sticks the first time the volume is created. Re-assert
# ownership for the current non-root user on container create so pnpm can
# always write to the store, even if the volume was first created by root or a
# different user. The store is shared and can hold hundreds of thousands of
# files, so skip the recursive chown when it's already ours, and never block
# container creation over it.
if [ "$(id -u)" != "0" ]; then
    USERNAME="$(id -un)"
    if [ "$(stat -c '%u' "${STORE_DIR}" 2>/dev/null)" = "$(id -u)" ]; then
        echo "${STORE_DIR} already owned by ${USERNAME}; skipping chown"
    elif command -v sudo >/dev/null 2>&1; then
        echo "Setting owner of ${STORE_DIR} to ${USERNAME}..."
        sudo -n chown -R "${USERNAME}:${USERNAME}" "${STORE_DIR}" \
            || echo "WARN: could not chown ${STORE_DIR} as ${USERNAME}"
    else
        echo "WARN: sudo unavailable and ${STORE_DIR} not owned by ${USERNAME}"
    fi
else
    echo "Running as root; leaving ${STORE_DIR} ownership unchanged."
fi
