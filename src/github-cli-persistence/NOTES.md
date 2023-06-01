## OS and Architecture Support

|        | amd64 | arm64 |
| ------ | ----- | ----- |
| ubuntu | ✅     | ✔️     |
| debian | ✅     | ✔️     |

- ✅: Tested and verified on Github Actions
- ✔️: Tested locally on my mac (but not on GHA)

## Changelog

| Version | Notes                                                |
| ------- | ---------------------------------------------------- |
| 0.0.3   | Delete some unnecessary "echo" statements            |
| 0.0.2   | `chown -R` the entire `~/.config` directory          |
| 0.0.1   | Rename ~/.config/gh to ~/.config/gh-old if it exists |
| 0.0.0   | Initial Version                                      |

## References

- [Github CLI Feature](https://github.com/devcontainers/features/tree/main/src/github-cli)
- [stuartleeks/azure-cli-persistence](https://github.com/stuartleeks/dev-container-features/tree/main/src/azure-cli-persistence)
