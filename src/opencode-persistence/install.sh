#!/bin/sh
set -e

USERNAME=${USERNAME:-${_REMOTE_USER}}
FEATURE_ID="opencode-persistence"
LIFECYCLE_SCRIPTS_DIR="/usr/local/share/${FEATURE_ID}/scripts"

create_cache_dir() {
    if [ -d "$1" ]; then
        echo "Directory $1 already exists. Skip creation..."
    else
        echo "Create directory $1..."
        mkdir -p "$1"
    fi

    if [ -z "$2" ]; then
        echo "No username provided. Skip chown..."
    else
        echo "Change owner of $1 to $2..."
        chown -R "$2:$2" "$1"
    fi
}

create_symlink_dir() {
    local_dir=$1
    cache_dir=$2
    username=$3

    if [ -z "$username" ]; then
        echo "No username provided. Skip symlink for $local_dir..."
        return 0
    fi

    # already linked to the right place? (e.g. layer cached from a previous build)
    if [ -L "$local_dir" ] && [ "$(readlink "$local_dir")" = "$cache_dir" ]; then
        echo "Symlink $local_dir -> $cache_dir already exists. Skip..."
        return 0
    fi

    runuser -u "$username" -- mkdir -p "$(dirname "$local_dir")"
    runuser -u "$username" -- mkdir -p "$cache_dir"

    # if the folder we want to symlink already exists, `ln -s` would create the
    # link INSIDE it instead of replacing it - move it aside
    if [ -e "$local_dir" ]; then
        echo "Moving existing $local_dir to $local_dir-old..."
        mv "$local_dir" "$local_dir-old"
    fi

    echo "Symlink $local_dir -> $cache_dir for $username..."
    runuser -u "$username" -- ln -s "$cache_dir" "$local_dir"
}

# volumes mount at runtime; creating the dirs in the image means fresh named
# volumes inherit this ownership on first mount (docker's copy-on-first-use)
create_cache_dir /dc/opencode/data "$USERNAME"
create_cache_dir /dc/opencode/config "$USERNAME"

create_symlink_dir "${_REMOTE_USER_HOME}/.local/share/opencode" /dc/opencode/data "$USERNAME"
create_symlink_dir "${_REMOTE_USER_HOME}/.config/opencode" /dc/opencode/config "$USERNAME"

# Set Lifecycle scripts
if [ -f oncreate.sh ]; then
    mkdir -p "${LIFECYCLE_SCRIPTS_DIR}"
    cp oncreate.sh "${LIFECYCLE_SCRIPTS_DIR}/oncreate.sh"
fi

echo "Finished installing $FEATURE_ID"
