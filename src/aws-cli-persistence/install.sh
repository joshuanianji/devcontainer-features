#!/bin/sh
set -e

echo "Activating feature 'aws-cli-persistence'"
echo "User: ${_REMOTE_USER}     User home: ${_REMOTE_USER_HOME}"

if [  -z "$_REMOTE_USER" ] || [ -z "$_REMOTE_USER_HOME" ]; then
  echo "***********************************************************************************"
  echo "*** Require _REMOTE_USER and _REMOTE_USER_HOME to be set (by dev container CLI) ***"
  echo "***********************************************************************************"
  exit 1
fi

# make /dc/aws-cli folder if doesn't exist
mkdir -p "/dc/aws-cli"

# as to why we move around the folder, check `github-cli-persistence/install.sh`
if [ -e "$_REMOTE_USER_HOME/.aws" ]; then
  echo "Moving existing .aws folder to .aws-old"
  mv "$_REMOTE_USER_HOME/.aws" "$_REMOTE_USER_HOME/.aws-old"
fi

ln -s /dc/aws-cli "$_REMOTE_USER_HOME/.aws"
# chown .aws folder
chown -R "${_REMOTE_USER}:${_REMOTE_USER}" "$_REMOTE_USER_HOME/.aws"

# chown mount (only attached on startup)
cat << EOF >> "$_REMOTE_USER_HOME/.bashrc"
sudo chown -R "${_REMOTE_USER}:${_REMOTE_USER}" /dc/aws-cli
EOF
chown -R $_REMOTE_USER $_REMOTE_USER_HOME/.bashrc
