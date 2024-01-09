#!/bin/sh
set -e

FEATURE_ID="aws-cli-persistence"

echo "Activating feature '$FEATURE_ID'"
echo "User: ${_REMOTE_USER}     User home: ${_REMOTE_USER_HOME}"

if [ -z "$_REMOTE_USER" ] || [ -z "$_REMOTE_USER_HOME" ]; then
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

# --- Generate a '$FEATURE_ID-post-create.sh' script to be executed by the 'postCreateCommand' lifecycle hook
# Looks like this is the best way to run a script in lifecycle hooks
# Source: https://github.com/devcontainers/features/blob/562305d37b97d47331d96306ffc2a0a3cce55e64/src/git-lfs/install.sh#L190C1-L190C109
POST_CREATE_SCRIPT_PATH="/usr/local/share/$FEATURE_ID-post-create.sh"

tee "$POST_CREATE_SCRIPT_PATH" >/dev/null \
    <<'EOF'
#!/bin/sh

set -e

# if the user is not root, chown /dc/aws-cli to the user
if [ "$(id -u)" != "0" ]; then
    echo "Running post-start.sh for user $USER"
    sudo chown -R "$USER:$USER" /dc/aws-cli
fi
EOF

chmod 755 "$POST_CREATE_SCRIPT_PATH"
