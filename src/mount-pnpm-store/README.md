
# Mount pnpm Store (mount-pnpm-store)

Mounts a shared Docker volume as the pnpm store directory so packages are downloaded once and reused across multiple devcontainers. Points pnpm at the volume via containerEnv — no pnpm invocation, no symlink.

## Example Usage

```json
"features": {
    "ghcr.io/joshuanianji/devcontainer-features/mount-pnpm-store:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|


## How it works

This feature shares one pnpm content-addressable store across every devcontainer on the host, so each package is downloaded and unpacked only once.

It does this with four declarative pieces and **no pnpm invocation**:

- **Named volume** `global-devcontainer-pnpm-store` mounted at `/dc/mounted-pnpm-store`. A named volume (not a workspace bind mount) is shared by all containers on the host — that is the entire sharing mechanism.
- **`containerEnv`** relocates the store with `NPM_CONFIG_STORE_DIR=/dc/mounted-pnpm-store`. pnpm honors `npm_config_*`-style settings, so this is the variable that actually moves the store across pnpm versions. `PNPM_CONFIG_STORE_DIR` is set to the same value as forward-looking coverage for pnpm's native `PNPM_CONFIG_*` variables (not honored for `store-dir` on pnpm 10.x, but harmless).
- **`install.sh`** creates the mount point and gives it to the remote user.
- **`oncreate.sh`** (`onCreateCommand`) re-asserts ownership for the current non-root user on every container create.

Because pnpm is never invoked, this feature avoids the `pnpm config set --global` / `PNPM_HOME` / PATH / non-interactive-shell problems that earlier versions (and the `~/.pnpm-store` symlink approach) had to patch. See issue [#80](https://github.com/joshuanianji/devcontainer-features/issues/80).

### Migrating from `1.0.x`

Version `1.1.0` is a behavior change: the `~/.pnpm-store` symlink is no longer created and pnpm is no longer invoked at onCreate. Instead, pnpm is pointed at the volume via `NPM_CONFIG_STORE_DIR`. The Docker volume name (`global-devcontainer-pnpm-store`) and mount target (`/dc/mounted-pnpm-store`) are unchanged, so existing volumes keep working — pnpm will simply read/write the same store at the same path.

A stale `~/.pnpm-store` symlink from a previous version is harmless (it still resolves to the mounted volume) and can be ignored; `NPM_CONFIG_STORE_DIR` takes precedence over any `store-dir` written to `~/.npmrc` by earlier versions.

## Ownership of the shared store

The named volume is mounted over `/dc/mounted-pnpm-store` at runtime, so the build-time `chown` in `install.sh` only sticks the first time the volume is created. `oncreate.sh` therefore `sudo chown`s the store to the current user on every create (skipped when running as `root`).

Note: if you use the same volume from devcontainers running as **different** users at the same time, each container's `onCreateCommand` will chown the store to its own user. This is inherent to sharing one store across users. The intended use is a single developer with a consistent remote user.

## Ensuring pnpm is installed

This feature does not install pnpm. It only configures where pnpm puts its store, so it works whether pnpm comes from the base image or another feature. There is a soft dependency (`installsAfter`) on `ghcr.io/devcontainers/features/node`, `common-utils`, and `fish`. If pnpm is installed by some other feature, you may need [`overrideFeatureInstallOrder`](https://containers.dev/implementors/features/#overrideFeatureInstallOrder) to make sure it runs before this one.

## OS and Architecture Support

Architectures: `amd` and `arm`

OS: `ubuntu`, `debian`

Shells: `bash`, `zsh`, `fish` (the feature sets environment only; it does not depend on the interactive shell)

## Volume Mount Naming

The volume is named `global-devcontainer-pnpm-store`. Ensure no other Docker volume collides with this name.

## Changelog

| Version | Notes                                                                                                                                   |
| ------- | --------------------------------------------------------------------------------------------------------------------------------------- |
| 1.1.0   | Switch to declarative `containerEnv` strategy: point pnpm at the volume via `NPM_CONFIG_STORE_DIR`, drop the symlink and pnpm invocation (resolves [#80](https://github.com/joshuanianji/devcontainer-features/issues/80) at the root). Pattern adapted from [itplusx/devcontainer-features/shared-pnpm-store](https://github.com/itplusx/devcontainer-features/tree/main/src/shared-pnpm-store). |
| 1.0.4   | Fix script name in output                                                                                                               |
| 1.0.3   | Fix pnpm global bin dir check in `oncreate.sh` (issue #80)                                                                              |
| 1.0.2   | Move onCreate lifecycle script to `oncreate.sh`                                                                                         |
| 1.0.1   | Fix Docs                                                                                                                                |
| 1.0.0   | Support zsh + refactor                                                                                                                  |
| 0.1.1   | Fix mount name                                                                                                                          |
| 0.1.0   | Documentation                                                                                                                           |
| 0.0.0   | Initial Version                                                                                                                         |

## References

- [Pnpm Devcontainer Setup by PatrickChoDev](https://gist.github.com/PatrickChoDev/81d36159aca4dc687b8c89983e64da2e)
- [itplusx/devcontainer-features/shared-pnpm-store](https://github.com/itplusx/devcontainer-features/tree/main/src/shared-pnpm-store) — origin of the `containerEnv` pattern.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/joshuanianji/devcontainer-features/blob/main/src/mount-pnpm-store/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
