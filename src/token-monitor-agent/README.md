
# Token Monitor Agent (token-monitor-agent)

Report token usage from this container's /dc volumes to a self-hosted Javis603/token-monitor hub.

## Example Usage

```json
"features": {
    "ghcr.io/joshuanianji/devcontainer-features/token-monitor-agent:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|


## What it does

Runs the [token-monitor](https://github.com/Javis603/token-monitor) headless agent (`npm run agent`, source checkout of `v0.61.0` — override via `TOKEN_MONITOR_VERSION` at build) inside every devcontainer, reporting usage from this container's `/dc/*` volumes to your hub. Images without node/npm get a silent no-op.

## Secret & scopes

Make a `~/.config/token-mon/env` on your local machine with the following env vars, or populate your devcoontainer with the same env vars via `devcontainer.json` or `.env`:

```sh
TOKEN_MONITOR_HUB_URL=...        # required, with SECRET, to activate
TOKEN_MONITOR_SECRET=...
TOKEN_MONITOR_CLIENTS=claude,opencode          # optional scopes (unset = all tools)
TOKEN_MONITOR_LIMIT_PROVIDERS=claude,zai      # optional (unset = all providers)
TOKEN_MONITOR_WATCH_POLLING=1    # only if container volumes never fire events
```

**Gotcha:** a missing env file either becomes a stray directory (Docker Desktop auto-creates) or a hard container-start error (DinD). Create it before first use.

## Changelog

| Version | Notes           |
| ------- | --------------- |
| 1.0.0   | Initial version |


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/joshuanianji/devcontainer-features/blob/main/src/token-monitor-agent/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
