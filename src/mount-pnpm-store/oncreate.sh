#!/bin/sh

set -e

# pnpm refuses --global commands (exit 1) when its global bin directory is
# not in PATH. This script runs as onCreateCommand in a non-interactive shell
# where rc-file exports are never loaded, so provide the environment here.
# The expected directory differs by pnpm version ($PNPM_HOME for pnpm <= 8,
# $PNPM_HOME/bin for pnpm >= 9), so put both on PATH; neither needs to exist
# for the check to pass.
export PNPM_HOME="${PNPM_HOME:-$HOME/.local/share/pnpm}"
export PATH="$PNPM_HOME/bin:$PNPM_HOME:$PATH"

# set pnpm config (if it's installed)
if type pnpm >/dev/null 2>&1; then
    echo "Setting pnpm store location to $HOME/.pnpm-store"
    pnpm config set store-dir ~/.pnpm-store --global
else
    echo "WARN: pnpm is not installed! Please ensure pnpm is installed and in your PATH."
    echo "WARN: pnpm store location will not be set."
fi

# if the user is not root, chown /dc/mounted-pnpm-store to the user
if [ "$(id -u)" != "0" ]; then
    echo "Running oncreate.sh for user $USER"
    sudo chown -R "$USER:$USER" /dc/mounted-pnpm-store
fi
