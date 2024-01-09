#!/bin/sh
set -e

FEATURE_ID="terraform-cli-persistence"

echo "Activating feature '$FEATURE_ID'"
echo "User: ${_REMOTE_USER}     User home: ${_REMOTE_USER_HOME}"

if [ -z "$_REMOTE_USER" ] || [ -z "$_REMOTE_USER_HOME" ]; then
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
    sudo chown -R "$USER:$USER" /dc/terraform-cli
fi
EOF

chmod 755 "$POST_CREATE_SCRIPT_PATH"
