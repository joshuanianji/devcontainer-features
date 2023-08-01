set -e

# Clean up
rm -rf /var/lib/apt/lists/*

VERSION=${VERSION:-"latest"}

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# Checks if packages are installed and installs them if not
check_packages() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
            echo "Running apt-get update..."
            apt-get update -y
        fi
        apt-get -y install --no-install-recommends "$@"
    fi
}

export DEBIAN_FRONTEND=noninteractive

check_packages curl

install() {
    architecture="$(uname -m)"

    # the arch naming system for Lamdera uses "arm64" for arm and "x86_64" for amd64
    # basically, `uname -m` and `dpkg --print-architecture` by themselves won't suffice
    if [[ $architecture = "x86_64" ]]; then
        ARCH="x86_64"
    elif [[ $architecture = "aarch64" ]]
        ARCH="arm64"
    else
        echo "Unsupported architecture: $architecture"
        exit 1
    fi

    # Hardcode the latest version of lamdera!!
    # TODO: fix this later!
    if [[ $VERSION = "latest" ]]; then
        VERSION="1.1.0"
    fi

    # Download and install lamdera
    # Echo HTTP status code: https://stackoverflow.com/a/18262020
    echo "Downloading Lamdera version $VERSION for architecture $ARCH..."
    STATUS=$(curl -s "https://static.lamdera.com/bin/lamdera-$VERSION-macos-$ARCH" -w %{http_code} -o /usr/local/bin/lamdera)
    if [[ $STATUS = "404" ]]; then
        echo "Lamdera version $VERSION for architecture $ARCH does not exist!"
        exit 1
    fi

    echo "Lamdera version $VERSION for architecture $ARCH downloaded successfully."

    chmod a+x /usr/local/bin/lamdera
}

echo "(*) Installing Lamdera CLI..."

install

# Clean up
rm -rf /var/lib/apt/lists/*

echo "Done!"