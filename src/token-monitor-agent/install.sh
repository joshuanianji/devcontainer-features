#!/bin/sh
set -e

FEATURE_ID="token-monitor-agent"
SCRIPTS_DIR="/usr/local/share/${FEATURE_ID}/scripts"
APP_DIR="/usr/local/share/${FEATURE_ID}/app"
USERNAME=${USERNAME:-${_REMOTE_USER}}
# bump via build arg / env when a newer release is wanted
TOKEN_MONITOR_VERSION=${TOKEN_MONITOR_VERSION:-v0.61.0}

mkdir -p "${SCRIPTS_DIR}"
cp start.sh oncreate.sh "${SCRIPTS_DIR}/"
chmod +x "${SCRIPTS_DIR}/start.sh" "${SCRIPTS_DIR}/oncreate.sh"

# create + chown the state dir in the image so a fresh named volume inherits
# user ownership via docker's copy-on-first-use
mkdir -p /dc/token-monitor/state
if [ -n "$USERNAME" ]; then
    chown -R "$USERNAME:$USERNAME" /dc/token-monitor/state
fi

# install the headless agent (source checkout of the token-monitor release)
if [ -d "${APP_DIR}/node_modules" ]; then
    echo "Agent app already installed; skipping download"
else
    if ! command -v curl >/dev/null 2>&1 || ! command -v npm >/dev/null 2>&1; then
        echo "WARN: curl/npm not available - agent app not installed; start.sh will stay silent"
        exit 0
    fi
    mkdir -p "${APP_DIR}"
    curl -fsSL "https://github.com/Javis603/token-monitor/archive/refs/tags/${TOKEN_MONITOR_VERSION}.tar.gz" \
        | tar xz --strip-components=1 -C "${APP_DIR}"
    (cd "${APP_DIR}" && npm install --omit=dev --no-audit --no-fund)
    # vendor the tokscale binary NOW (as root, at build time): the agent's
    # `npm run agent` re-runs `ensure:tokscale` at startup and would fail
    # with EACCES trying to write into root-owned node_modules as the user
    (cd "${APP_DIR}" && npm run ensure:tokscale) \
        || echo "WARN: ensure:tokscale failed at build; agent may fail at runtime"
fi

echo "Finished installing ${FEATURE_ID} (${TOKEN_MONITOR_VERSION})"
