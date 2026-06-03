#!/bin/sh

set -e

# if the user is not root, chown /dc/terraform-cli to the user
if [ "$(id -u)" != "0" ]; then
    echo "Running oncreate.sh for user $USER"
    sudo chown -R "$USER:$USER" /dc/terraform-cli
fi
