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