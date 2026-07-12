#!/bin/sh

set -e

USERNAME=${USERNAME:-${_REMOTE_USER}}
FEATURE_ID="mount-pnpm-store"
STORE_DIR="/dc/mounted-pnpm-store"
LIFECYCLE_SCRIPTS_DIR="/usr/local/share/${FEATURE_ID}/scripts"

echo "Ensuring pnpm store directory ${STORE_DIR} exists..."
mkdir -p "${STORE_DIR}"

if [ -n "${USERNAME}" ] && [ "${USERNAME}" != "root" ]; then
    echo "Setting owner of ${STORE_DIR} to ${USERNAME}..."
    chown -R "${USERNAME}:${USERNAME}" "${STORE_DIR}"
else
    echo "No non-root user; leaving ${STORE_DIR} owned by root."
fi

# Install lifecycle script (re-asserts ownership at container create time)
if [ -f oncreate.sh ]; then
    echo "Installing oncreate.sh to ${LIFECYCLE_SCRIPTS_DIR}..."
    mkdir -p "${LIFECYCLE_SCRIPTS_DIR}"
    cp oncreate.sh "${LIFECYCLE_SCRIPTS_DIR}/oncreate.sh"
    chmod +x "${LIFECYCLE_SCRIPTS_DIR}/oncreate.sh"
fi

echo "Finished installing ${FEATURE_ID}"
