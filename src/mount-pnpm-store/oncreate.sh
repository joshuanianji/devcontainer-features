#!/bin/sh

set -e

# set pnpm config (if it's installed)
if type pnpm >/dev/null 2>&1; then
    echo "Setting pnpm store location to $_REMOTE_USER_HOME/.pnpm-store"
    pnpm config set store-dir ~/.pnpm-store --global
else
    echo "WARN: pnpm is not installed! Please ensure pnpm is installed and in your PATH."
    echo "WARN: pnpm store location will not be set."
fi

# if the user is not root, chown /dc/mounted-pnpm-store to the user
if [ "$(id -u)" != "0" ]; then
    echo "Running post-start.sh for user $USER"
    sudo chown -R "$USER:$USER" /dc/mounted-pnpm-store
fi
