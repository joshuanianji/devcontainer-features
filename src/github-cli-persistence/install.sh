#!/bin/sh
set -e

FEATURE_ID="gcloud-cli-persistence"

echo "Activating feature '$FEATURE_ID'"
echo "User: ${_REMOTE_USER}     User home: ${_REMOTE_USER_HOME}"

if [ -z "$_REMOTE_USER" ] || [ -z "$_REMOTE_USER_HOME" ]; then
    echo "***********************************************************************************"
    echo "*** Require _REMOTE_USER and _REMOTE_USER_HOME to be set (by dev container CLI) ***"
    echo "***********************************************************************************"
    exit 1
fi

# make ~/.config folder if doesn't exist
mkdir -p "$_REMOTE_USER_HOME/.config"
mkdir -p "/dc/github-cli"

# if `.config/gh` already exists, the `ln -s` command will create an extra
# folder *inside* `.config/gh` that symlinks to `github-cli`
# Thus, we want to make sure the folder does NOT exist so the symlink will actually be to ~/.config/gh
if [ -e "$_REMOTE_USER_HOME/.config/gh" ]; then
    echo "Moving existing gh folder to gh-old"
    mv "$_REMOTE_USER_HOME/.config/gh" "$_REMOTE_USER_HOME/.config/gh-old"
fi

ln -s /dc/github-cli "$_REMOTE_USER_HOME/.config/gh"
# chown the entire `.config` folder because devcontainers creates
# a `~/.config/vscode-dev-containers` folder later on
chown -R "${_REMOTE_USER}:${_REMOTE_USER}" "$_REMOTE_USER_HOME/.config"

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
    sudo chown -R "$USER:$USER" /dc/github-cli
fi
EOF

chmod 755 "$POST_CREATE_SCRIPT_PATH"
