#!/bin/sh
set -e

echo "Activating feature 'terraform-cli-persistence'"
echo "User: ${_REMOTE_USER}     User home: ${_REMOTE_USER_HOME}"

if [  -z "$_REMOTE_USER" ] || [ -z "$_REMOTE_USER_HOME" ]; then
  echo "***********************************************************************************"
  echo "*** Require _REMOTE_USER and _REMOTE_USER_HOME to be set (by dev container CLI) ***"
  echo "***********************************************************************************"
  exit 1
fi

# make /dc/terraform-cli folder if doesn't exist
mkdir -p "/dc/terraform-cli"

# as to why we move around the folder, check `github-cli-persistence/install.sh`
if [ -e "$_REMOTE_USER_HOME/.terraform.d" ]; then
  echo "Moving existing .terraform.d folder to .terraform.d-old"
  mv "$_REMOTE_USER_HOME/.terraform.d" "$_REMOTE_USER_HOME/.terraform.d-old"
fi

ln -s /dc/terraform-cli "$_REMOTE_USER_HOME/.terraform.d"
# chown the entire `.config` folder because devcontainers creates 
# a `~/.config/vscode-dev-containers` folder later on 
chown -R "${_REMOTE_USER}:${_REMOTE_USER}" "$_REMOTE_USER_HOME/.terraform.d"

# chown mount (only attached on startup)
cat << EOF >> "$_REMOTE_USER_HOME/.bashrc"
sudo chown -R "${_REMOTE_USER}:${_REMOTE_USER}" /dc/terraform-cli
EOF
chown -R $_REMOTE_USER $_REMOTE_USER_HOME/.bashrc
