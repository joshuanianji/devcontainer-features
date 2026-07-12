## Why this fork?

This is a fork of [`ghcr.io/dhoeric/features/google-cloud-cli`](https://github.com/dhoeric/features/tree/main/src/google-cloud-cli). It ships two fixes that have been pending upstream for over half a year:

1. **Trixie-compatible key import.** The upstream feature imports Google's apt key with `apt-key`, which was [removed in Debian 13 (trixie)](https://wiki.debian.org/NewInTrixie) and Ubuntu 24.04, so it fails with `apt-key: command not found` (exit 127) on those distributions. We use `gpg --dearmor` instead (the fix from [dhoeric/features#36](https://github.com/dhoeric/features/pull/36)).
2. **Working `installGkeGcloudAuthPlugin` option.** The devcontainer feature runtime exposes options as environment variables by uppercasing the option name (`installGkeGcloudAuthPlugin` -> `INSTALLGKEGCLOUDAUTHPLUGIN`, no underscores). The upstream feature reads `INSTALL_GKEGCLOUDAUTH_PLUGIN` (with an underscore), which is never set, so the option silently does nothing. We read the correctly-named variable.

Otherwise the feature is identical to the upstream one (same options, same apt source).

See [joshuanianji/devcontainer-features#90](https://github.com/joshuanianji/devcontainer-features/issues/90).

## Options

| Option | Description | Default |
| --- | --- | --- |
| `version` | gcloud CLI version to install (or `latest`) | `latest` |
| `installGkeGcloudAuthPlugin` | Also install the `gke-gcloud-auth-plugin` package | `false` |

## OS and Architecture Support

Architectures: `amd` and `arm`

OS: `ubuntu`, `debian` (including Debian 13/trixie and Ubuntu 24.04+)

Shells: `bash`, `zsh`, `fish`

## Changelog

| Version | Notes |
| ------- | ----- |
| 1.0.0   | Initial fork of `ghcr.io/dhoeric/features/google-cloud-cli@1.0.1` with `gpg --dearmor` key import (fixes [dhoeric/features#36](https://github.com/dhoeric/features/pull/36), [joshuanianji/devcontainer-features#90](https://github.com/joshuanianji/devcontainer-features/issues/90)). |

## References

- Upstream: [dhoeric/features/src/google-cloud-cli](https://github.com/dhoeric/features/tree/main/src/google-cloud-cli)
- Pending upstream fix: [dhoeric/features#36](https://github.com/dhoeric/features/pull/36)
