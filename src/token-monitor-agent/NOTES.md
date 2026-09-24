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

## Data sources

- Claude: `/dc/claude` via `CLAUDE_CONFIG_DIR` + the `~/.claude` symlink from claude-code-persistence
- OpenCode: `/dc/opencode/data` via the `~/.local/share/opencode` symlink

## Changelog

| Version | Notes           |
| ------- | --------------- |
| 1.0.0   | Initial version |
