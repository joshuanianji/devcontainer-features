#!/usr/bin/env bash

set -e

# if the user is not root, chown /dc/edgedb-cli to the user
if [ "$(id -u)" != "0" ]; then
    echo "Running oncreate.sh for user $USER"
    sudo chown -R "$USER:$USER" /dc/gel-cli
fi
