
# Github CLI Persistence (github-cli-persistence)

Avoid extra logins from the Github CLI by preserving the `~/.config/gh` folder across container instances.

## Example Usage

```json
"features": {
    "ghcr.io/joshuanianji/devcontainer-features/github-cli-persistence:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|


## OS and Architecture Support

Architectures: `amd` and `arm`

OS: `ubuntu`, `debian`

Shells: `bash`, `zsh`, `fish`

## Changelog

| Version | Notes                                                |
| ------- | ---------------------------------------------------- |
| 1.0.2   | Update soft dependencies                             |
| 1.0.1   | Fix Docs                                             |
| 1.0.0   | Support zsh + refactor                               |
| 0.0.3   | Delete some unnecessary "echo" statements            |
| 0.0.2   | `chown -R` the entire `~/.config` directory          |
| 0.0.1   | Rename ~/.config/gh to ~/.config/gh-old if it exists |
| 0.0.0   | Initial Version                                      |

## References

- [Github CLI Feature](https://github.com/devcontainers/features/tree/main/src/github-cli)
- [stuartleeks/azure-cli-persistence](https://github.com/stuartleeks/dev-container-features/tree/main/src/azure-cli-persistence)


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/joshuanianji/devcontainer-features/blob/main/src/github-cli-persistence/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
