#!/bin/sh
set -e

USERNAME=${USERNAME:-${_REMOTE_USER}}
FEATURE_ID="claude-code-persistence"
LIFECYCLE_SCRIPTS_DIR="/usr/local/share/${FEATURE_ID}/scripts"

# /dc/claude does not exist at build time (the volume mounts over it at runtime),
# but creating it in the image means a fresh named volume inherits its ownership
# on first mount (docker's copy-on-first-use).
if [ -d /dc/claude ]; then
    echo "Directory /dc/claude already exists. Skip creation..."
else
    echo "Create directory /dc/claude..."
    mkdir -p /dc/claude
fi

if [ -z "$USERNAME" ]; then
    echo "No username provided. Skip chown..."
else
    echo "Change owner of /dc/claude to $USERNAME..."
    chown -R "$USERNAME:$USERNAME" /dc/claude
fi

# CLAUDE_CONFIG_DIR is set via `containerEnv` in devcontainer-feature.json.
# Also export it for login shells that do not inherit container env (e.g. SSH).
echo 'export CLAUDE_CONFIG_DIR=/dc/claude' > /etc/profile.d/00-claude-code-persistence.sh

# symlink ~/.claude -> /dc/claude for tools that ignore CLAUDE_CONFIG_DIR and
# hardcode ~/.claude (usage monitors reading ~/.claude/projects, etc.)
if [ -n "$USERNAME" ] && [ -n "${_REMOTE_USER_HOME:-}" ]; then
    if [ -L "${_REMOTE_USER_HOME}/.claude" ] && [ "$(readlink "${_REMOTE_USER_HOME}/.claude")" = "/dc/claude" ]; then
        echo "~/.claude symlink already in place"
    else
        if [ -e "${_REMOTE_USER_HOME}/.claude" ]; then
            echo "Moving existing ${_REMOTE_USER_HOME}/.claude to ${_REMOTE_USER_HOME}/.claude-old..."
            mv "${_REMOTE_USER_HOME}/.claude" "${_REMOTE_USER_HOME}/.claude-old"
        fi
        runuser -u "$USERNAME" -- mkdir -p "$(dirname "${_REMOTE_USER_HOME}/.claude")"
        runuser -u "$USERNAME" -- ln -s /dc/claude "${_REMOTE_USER_HOME}/.claude"
    fi
fi

# Set Lifecycle scripts
if [ -f oncreate.sh ]; then
    mkdir -p "${LIFECYCLE_SCRIPTS_DIR}"
    cp oncreate.sh "${LIFECYCLE_SCRIPTS_DIR}/oncreate.sh"
fi

echo "Finished installing $FEATURE_ID"
