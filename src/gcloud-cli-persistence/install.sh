#!/bin/sh
set -e

echo "Activating feature 'gcloud-cli-persistence'"
echo "User: ${_REMOTE_USER}     User home: ${_REMOTE_USER_HOME}"

if [ -z "$_REMOTE_USER" ] || [ -z "$_REMOTE_USER_HOME" ]; then
    echo "***********************************************************************************"
    echo "*** Require _REMOTE_USER and _REMOTE_USER_HOME to be set (by dev container CLI) ***"
    echo "***********************************************************************************"
    exit 1
fi

# make ~/.config folder if doesn't exist
mkdir -p "$_REMOTE_USER_HOME/.config"
mkdir -p "/dc/gcloud-cli"

# if `.config/gcloud` already exists, the `ln -s` command will create an extra
# folder *inside* `.config/gcloud` that symlinks to `gcloud-cli`
# Thus, we want to make sure the folder does NOT exist so the symlink will actually be to ~/.config/gcloud
if [ -e "$_REMOTE_USER_HOME/.config/gcloud" ]; then
    echo "Moving existing gcloud folder to gcloud-old"
    mv "$_REMOTE_USER_HOME/.config/gcloud" "$_REMOTE_USER_HOME/.config/gcloud-old"
fi

ln -s /dc/gcloud-cli "$_REMOTE_USER_HOME/.config/gcloud"
# chown the entire `.config` folder because devcontainers creates
# a `~/.config/vscode-dev-containers` folder later on
chown -R "${_REMOTE_USER}:${_REMOTE_USER}" "$_REMOTE_USER_HOME/.config"

# chown mount (only attached on startup)
cat <<EOF >>"$_REMOTE_USER_HOME/.bashrc"
sudo chown -R "${_REMOTE_USER}:${_REMOTE_USER}" /dc/gcloud-cli
EOF
chown -R $_REMOTE_USER $_REMOTE_USER_HOME/.bashrc
