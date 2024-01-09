#!/bin/sh
set -e

echo "Activating feature 'mount-pnpm-store'"
echo "User: ${_REMOTE_USER}     User home: ${_REMOTE_USER_HOME}"

if [ -z "$_REMOTE_USER" ] || [ -z "$_REMOTE_USER_HOME" ]; then
    echo "***********************************************************************************"
    echo "*** Require _REMOTE_USER and _REMOTE_USER_HOME to be set (by dev container CLI) ***"
    echo "***********************************************************************************"
    exit 1
fi

# make /dc/mounted-pnpm-store folder if doesn't exist
mkdir -p "/dc/mounted-pnpm-store"

# as to why we move around the folder, check `github-cli-persistence/install.sh`
if [ -e "$_REMOTE_USER_HOME/.pnpm-store" ]; then
    echo "Moving existing .pnpm-store folder to .pnpm-store-old"
    mv "$_REMOTE_USER_HOME/.pnpm-store" "$_REMOTE_USER_HOME/.pnpm-store-old"
fi

ln -s /dc/mounted-pnpm-store "$_REMOTE_USER_HOME/.pnpm-store"
chown -R "$_REMOTE_USER:$_REMOTE_USER" "$_REMOTE_USER_HOME/.pnpm-store"

# set pnpm store location
# if pnpm is not installed, print out a warning
if type pnpm >/dev/null 2>&1; then
    echo "Setting pnpm store location to $_REMOTE_USER_HOME/.pnpm-store"
    # we have to run the `pnpm config set store-dir` as the remote user
    # because the remote user is the one that will be using pnpm
    runuser -l $_REMOTE_USER -c "pnpm config set store-dir $_REMOTE_USER_HOME/.pnpm-store --global"
else
    echo "WARN: pnpm is not installed! Please ensure pnpm is installed and in your PATH."
    echo "WARN: pnpm store location will not be set."
fi
