## Important Implementation Details

### pnpm `store-dir`

This is opinionated, but I dislike the pnpm store being in the workspace along with your code as it adds clutter. This feature sets the pnpm `store-dir` config to `~/.pnpm-store`, so it's out of sight. The home directory will be based on the `remoteUser` of the base image you have.

### Ensuring pnpm is installed

This feature does not install pnpm by itself and expects `pnpm` to be installed already, either by a base image or by a feature. If pnpm is not installed, it just gives a warning (you'll have a random ~/.pnpm-store folder in your home directory and the pnpm `store-dir` config will not be set) but does not fail.

If you are installing pnpm with a feature, you may need to ensure it is run **before** `mount-pnpm-store`. To make this work, use the [`overrideFeatureInstallOrder` property](https://containers.dev/implementors/features/#overrideFeatureInstallOrder), since the default feature installation order is based on ID (alphanumerically i think). Here is an example using `features/node`:

```json
    "image": "mcr.microsoft.com/devcontainers/base:bullseye",
    "features": {
        "ghcr.io/devcontainers/features/node:1": {
            "version": "20"
        },
        "ghcr.io/joshuanianji/devcontainer-features/mount-pnpm-store": {}
    },
    "overrideFeatureInstallOrder": [
        "ghcr.io/devcontainers/features/node", 
        "ghcr.io/joshuanianji/devcontainer-features/mount-pnpm-store"
    ]
```

### Volume Mount Naming

The volume mount is called `global-devcontainer-pnpm-store`, so ensure that no other docker volumes match this name.

## Changelog

| Version | Notes                                                |
| ------- | ---------------------------------------------------- |
| 0.1.1   | Fix mount name                                       |
| 0.1.0   | Documentation                                        |
| 0.0.0   | Initial Version                                      |

## References

- [Pnpm Devcontainer Setup by PatrickChoDev](https://gist.github.com/PatrickChoDev/81d36159aca4dc687b8c89983e64da2e)
