#!/bin/sh
set -e

# Env contract (see ~/.config/token-mon/env on the host, bind-mounted
# read-only at /dc/token-monitor/config/env): TOKEN_MONITOR_HUB_URL,
# TOKEN_MONITOR_SECRET, plus optional TOKEN_MONITOR_CLIENTS / LIMIT_PROVIDERS
# (scopes), DEVICE_ID, WATCH_POLLING... Real environment variables win.
ENV_FILE=/dc/token-monitor/config/env
if [ -f "$ENV_FILE" ]; then
    # set -a: export everything the file defines, so the agent (a child
    # process) actually receives it - sourcing alone keeps them as shell vars
    set -a
    . "$ENV_FILE"
    set +a
fi

# no configuration? stay silent - never break container startup, never make
# teammates' containers noisy
if [ -z "${TOKEN_MONITOR_SECRET:-}" ] || [ -z "${TOKEN_MONITOR_HUB_URL:-}" ]; then
    echo "token-monitor-agent: no secret/hub configured; staying silent"
    exit 0
fi

APP_DIR=/usr/local/share/token-monitor-agent/app
if [ ! -d "${APP_DIR}/node_modules" ] || ! command -v npm >/dev/null 2>&1; then
    echo "token-monitor-agent: agent app not installed (needs curl+npm at build); staying silent"
    exit 0
fi

# stable per-project device id: container hostnames churn per rebuild and
# would flood the hub's device list, so default to dc-<workspace-basename>.
# Simultaneous containers of the SAME project then merge into one device
# instead of double-counting.
if [ -z "${TOKEN_MONITOR_DEVICE_ID:-}" ]; then
    _base="$(basename "${PWD:-/workspace}" | tr '[:upper:]' '[:lower:]' | tr -cs 'a-z0-9' '-' | sed 's/^-//;s/-$//')"
    # never emit a bare "dc-": manual runs outside the workspace yield an
    # empty basename, so fall back to the container hostname instead
    [ -n "$_base" ] || _base="container-$(hostname 2>/dev/null || echo unknown)"
    TOKEN_MONITOR_DEVICE_ID="dc-${_base}"
    export TOKEN_MONITOR_DEVICE_ID
fi

mkdir -p /dc/token-monitor/state
cd "${APP_DIR}"
nohup npm run agent >>/dc/token-monitor/state/monitor.log 2>&1 &
echo "token-monitor-agent: started as ${TOKEN_MONITOR_DEVICE_ID} (pid $!)"
