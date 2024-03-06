#!/bin/sh

USERNAME=${USERNAME:-${_REMOTE_USER}}

LIFECYCLE_SCRIPTS_DIR="/usr/local/share/edgedb-cli/scripts"

set -e

create_cache_dir() {
    if [ -d "$1" ]; then
        echo "Cache directory $1 already exists. Skip creation..."
    else
        echo "Create cache directory $1..."
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
    # ln -s target_dir source_dir
    local source_dir=$1
    local target_dir=$2
    local username=$3

    if [ -d "$source_dir" ]; then
        echo "Symlink $source_dir to $target_dir..."
        ln -s "$source_dir" "$target_dir"
    else
        echo "Creating source dir $source_dir..."
        mkdir -p "$source_dir"
    fi

    # if the folder we want to symlink already exists, the ln -s command will create a folder inside the existing folder
    if [ -e "$source_dir" ]; then
        echo "Moving existing $source_dir folder to $source_dir-old"
        mv "$source_dir" "$source_dir-old"
    fi

    echo "Symlink $source_dir to $target_dir..."
    ln -s "$target_dir" "$source_dir"

    echo "Change owner of $source_dir to $username..."
    chown -R "$username:$username" "$source_dir"
}

install_edgedb() {
    echo "Installing EdgeDB CLI..."
    curl https://sh.edgedb.com --proto '=https' -sSf1 | sh -s -- -y
}

export DEBIAN_FRONTEND=noninteractive

create_cache_dir "/dc/edgedb-cli" "${USERNAME}"
create_symlink_dir "$_REMOTE_USER_HOME/.local/share/edgedb" "/dc/edgedb-cli" "${USERNAME}"
install_edgedb

# Set Lifecycle scripts
if [ -f oncreate.sh ]; then
    mkdir -p "${LIFECYCLE_SCRIPTS_DIR}"
    cp oncreate.sh "${LIFECYCLE_SCRIPTS_DIR}/oncreate.sh"
fi

echo "Done!"
