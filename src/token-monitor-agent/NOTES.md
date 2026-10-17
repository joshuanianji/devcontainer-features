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

**The env file is required.** It's bind-mounted from the host, and Docker refuses to start the container when a bind source is missing (`bind source path does not exist`), including on Docker Desktop. That means every container using this feature (including via `dev.containers.defaultFeatures`) fails to start on a machine without the file. Create it before first use. To opt out on a machine without changing which features you use, create an empty file. `start.sh` stays silent when the hub URL or secret is unset:

```sh
mkdir -p ~/.config/token-mon && touch ~/.config/token-mon/env
```

## Changelog

| Version | Notes           |
| ------- | --------------- |
| 1.0.2   | Docs: the env file is required; a missing file blocks container start (Docker Desktop doesn't auto-create it) |
| 1.0.1   | Detach agent with `setsid` so it survives the postStartCommand TTY closing (#114) |
| 1.0.0   | Initial version |
