## Changelog

| Version | Notes           |
| ------- | --------------- |
| 0.0.0   | Initial Version |

## Lamdera Versions

**Latest tag is hardcoded to v1.1.0!** I'm not sure how to get the latest lamdera version automatically (without web scraping the lamdera site which won't be pretty), so currently this is the solution I have.

The installation script looks at your OS architecture and version and interpolates it into the following (simplified) command:
```bash
curl "https://static.lamdera.com/bin/lamdera-$VERSION-linux-$ARCH"
```
Based on my tests, the latest Lamdera version is the only one that works reliably.

## OS and Arch Support

`v1.1.0` Supports the following OS and architectures:

|        | amd64 | arm64 |
| ------ | ----- | ----- |
| ubuntu | ✅     | ✔️     |
| debian | ✅     | ✔️     |

- ✅: Tested and verified on Github Actions
- ✔️: Tested locally on my mac (but not on GHA)

Other lamdera versions are not tested, but please submit an issue/PR if you need to use them!

## References

- [Lamdera](https://dashboard.lamdera.app/docs/download) 
