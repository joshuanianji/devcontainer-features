#!/bin/sh

USERNAME=${USERNAME:-${_REMOTE_USER}}

LIFECYCLE_SCRIPTS_DIR="/usr/local/share/edgedb-cli/scripts"

set -e

# Checks if packages are installed and installs them if not
check_packages() {
    if ! dpkg -s "$@" >/dev/null 2>&1; then
        if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
            echo "Running apt-get update..."
            apt-get update -y
        fi
        apt-get -y install --no-install-recommends "$@"
    fi
}

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
    # local dir is the folder edgedb will use
    # cache_dir is the /dc/edgedb-cli folder
    local local_dir=$1
    local cache_dir=$2
    local username=$3

    runuser -u "$username" -- mkdir -p "$(dirname "$local_dir")"
    runuser -u "$username" -- mkdir -p "$cache_dir"

    # if the folder we want to symlink already exists, the ln -s command will create a folder inside the existing folder
    if [ -e "$local_dir" ]; then
        echo "Moving existing $local_dir folder to $local_dir-old"
        mv "$local_dir" "$local_dir-old"
    fi

    echo "Symlink $local_dir to $cache_dir for $username..."
    runuser -u "$username" -- ln -s "$cache_dir" "$local_dir"
}

install_edgedb() {
    local username=$1

    echo "Installing EdgeDB CLI..."
    curl https://sh.edgedb.com --proto '=https' -sSf1 -o /tmp/edgedb-cli.sh
    chmod +x /tmp/edgedb-cli.sh

    # install edgedb for a specific user if possible
    echo "Installing EdgeDB CLI for $username..."
    if [ -z "$username" ]; then
        /tmp/edgedb-cli.sh -y
    else
        runuser -u "$username" -- /tmp/edgedb-cli.sh -y
    fi
}

export DEBIAN_FRONTEND=noninteractive

check_packages curl ca-certificates

# cache data directory
create_cache_dir "/dc/edgedb-cli/data" "${USERNAME}"
create_symlink_dir "$_REMOTE_USER_HOME/.local/share/edgedb" "/dc/edgedb-cli/data" "${USERNAME}"

# cache config directory
create_cache_dir "/dc/edgedb-cli/config" "${USERNAME}"
create_symlink_dir "$_REMOTE_USER_HOME/.config/edgedb" "/dc/edgedb-cli/config" "${USERNAME}"

install_edgedb "${USERNAME}"

# Set Lifecycle scripts
if [ -f oncreate.sh ]; then
    mkdir -p "${LIFECYCLE_SCRIPTS_DIR}"
    cp oncreate.sh "${LIFECYCLE_SCRIPTS_DIR}/oncreate.sh"
fi

echo "Done!"
