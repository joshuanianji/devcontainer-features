#!/bin/sh

set -e

STORE_DIR="/dc/mounted-pnpm-store"

# The shared named volume is mounted over STORE_DIR at runtime, so build-time
# ownership only sticks the first time the volume is created. Re-assert
# ownership for the current non-root user on every container create so pnpm can
# always write to the store, even if the volume was first created by root or a
# different user.
if [ "$(id -u)" != "0" ]; then
    USERNAME="$(id -un)"
    echo "Setting owner of ${STORE_DIR} to ${USERNAME}..."
    sudo chown -R "${USERNAME}:${USERNAME}" "${STORE_DIR}"
else
    echo "Running as root; leaving ${STORE_DIR} ownership unchanged."
fi
