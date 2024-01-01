#!/bin/sh
set -e

echo "Activating feature 'mount-pnpm-store'"
echo "User: ${_REMOTE_USER}     User home: ${_REMOTE_USER_HOME}"

if [  -z "$_REMOTE_USER" ] || [ -z "$_REMOTE_USER_HOME" ]; then
    echo "***********************************************************************************"
    echo "*** Require _REMOTE_USER and _REMOTE_USER_HOME to be set (by dev container CLI) ***"
    echo "***********************************************************************************"
    exit 1
fi

# if pnpm is not installed, fail
if ! pnpm --version >/dev/null 2>&1; then
    echo "PNPM is not installed! Please ensure pnpm is installed and in your PATH."
    exit 1
fi

# make /dc/pnpm-store folder if doesn't exist
mkdir -p "/dc/pnpm-store"

# as to why we move around the folder, check `github-cli-persistence/install.sh`
if [ -e "$_REMOTE_USER_HOME/.pnpm-store" ]; then
  echo "Moving existing .pnpm-store folder to .pnpm-store-old"
  mv "$_REMOTE_USER_HOME/.pnpm-store" "$_REMOTE_USER_HOME/.pnpm-store-old"
fi

ln -s /dc/pnpm-store "$_REMOTE_USER_HOME/.pnpm-store"
# chown the entire `.config` folder because devcontainers creates 
# a `~/.config/vscode-dev-containers` folder later on 
chown -R "$_REMOTE_USER:$_REMOTE_USER" "$_REMOTE_USER_HOME/.pnpm-store"

# chown mount (only attached on startup)
cat << EOF >> "$_REMOTE_USER_HOME/.bashrc"
sudo chown -R "$_REMOTE_USER:$_REMOTE_USER" /dc/pnpm-store
EOF
chown -R $_REMOTE_USER $_REMOTE_USER_HOME/.bashrc

# set pnpm store location
pnpm config set store-dir "$_REMOTE_USER_HOME/.pnpm-store"
