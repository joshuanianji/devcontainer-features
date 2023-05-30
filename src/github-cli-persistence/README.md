
# Github CLI Persistence (github-cli-persistence)

Avoid extra logins from the Github CLI by preserving the `~/.config/gh` folder across container instances.

## Example Usage

```json
"features": {
    "ghcr.io/joshuanianji/devcontainer-features/github-cli-persistence:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|


## Notes

- This feature assumes you have the `ghcr.io/devcontainers/features/github-cli` feature installed as well.

## OS and Architecture Support

|        | amd64 | arm64 |
| ------ | ----- | ----- |
| ubuntu | ✅     | ✔️     |
| debian | ✅     | ✔️     |

- ✅: Tested and verified on Github Actions
- ✔️: Tested locally on my mac (but not on GHA)

## Changelog

| Version | Notes                                                            |
| ------- | ---------------------------------------------------------------- |
| 0.0.1   | Rename existing ~/.config/gh folder to ~/.config/gh if it exists |
| 0.0.0   | Initial Version                                                  |

## References

- [Github CLI Feature](https://github.com/devcontainers/features/tree/main/src/github-cli)
- [stuartleeks/azure-cli-persistence](https://github.com/stuartleeks/dev-container-features/tree/main/src/azure-cli-persistence)


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/joshuanianji/devcontainer-features/blob/main/src/github-cli-persistence/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
