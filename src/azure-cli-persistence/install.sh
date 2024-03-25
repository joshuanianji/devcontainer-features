#!/bin/sh

USERNAME=${USERNAME:-${_REMOTE_USER}}
FEATURE_ID="azure-cli-persistence"
LIFECYCLE_SCRIPTS_DIR="/usr/local/share/${FEATURE_ID}/scripts"

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

create_cache_dir "/dc/azure-cli" "${USERNAME}"
create_symlink_dir "$_REMOTE_USER_HOME/.azure" "/dc/azure-cli" "${USERNAME}"

# Set Lifecycle scripts
if [ -f oncreate.sh ]; then
    mkdir -p "${LIFECYCLE_SCRIPTS_DIR}"
    cp oncreate.sh "${LIFECYCLE_SCRIPTS_DIR}/oncreate.sh"
fi

echo "Finished installing $FEATURE_ID"
