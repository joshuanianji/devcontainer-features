#!/bin/sh

USERNAME=${USERNAME:-${_REMOTE_USER}}

LIFECYCLE_SCRIPTS_DIR="/usr/local/share/gel-cli/scripts"

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
    # local dir is the folder gel will use
    # cache_dir is the /dc/gel-cli folder
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

install_cli() {
    local username=$1

    echo "Installing Gel CLI..."
    curl https://www.geldata.com/sh --proto '=https' --tlsv1.2 -sSf -o /tmp/gel-cli.sh
    chmod +x /tmp/gel-cli.sh

    # install gel for a specific user if possible
    echo "Installing Gel CLI for $username..."
    if [ -z "$username" ]; then
        /tmp/gel-cli.sh -y
    else
        runuser -u "$username" -- /tmp/gel-cli.sh -y
    fi
}

export DEBIAN_FRONTEND=noninteractive

check_packages curl ca-certificates

# cache data directory
create_cache_dir "/dc/gel-cli/data" "${USERNAME}"
create_symlink_dir "$_REMOTE_USER_HOME/.local/share/gel" "/dc/gel-cli/data" "${USERNAME}"

# cache config directory
create_cache_dir "/dc/gel-cli/config" "${USERNAME}"
create_symlink_dir "$_REMOTE_USER_HOME/.config/gel" "/dc/gel-cli/config" "${USERNAME}"

install_cli "${USERNAME}"

# Set Lifecycle scripts
if [ -f oncreate.sh ]; then
    mkdir -p "${LIFECYCLE_SCRIPTS_DIR}"
    cp oncreate.sh "${LIFECYCLE_SCRIPTS_DIR}/oncreate.sh"
fi

echo "Done!"
