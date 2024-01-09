## Lamdera Versions

**Latest tag is hardcoded to v1.1.0!** I'm not sure how to get the latest lamdera version automatically (without web scraping the lamdera site which won't be pretty), so currently this is the solution I have.

The installation script looks at your OS architecture and version and interpolates it into the following (simplified) command:
```bash
curl "https://static.lamdera.com/bin/lamdera-$VERSION-linux-$ARCH"
```
Based on my tests, v1.1.0 is the only one that works reliably.

## OS and Architecture Support

Architectures: `amd` and `arm`.
OS: `ubuntu`, `debian`
Shells: `bash`, `zsh`, `fish`

## Changelog

| Version | Notes                         |
| ------- | ----------------------------- |
| 1.0.0   | Support zsh/fish and refactor |
| 0.0.2   | Fix typos in Docs             |
| 0.0.1   | Update Docs                   |
| 0.0.0   | Initial Version               |

## References

- [Lamdera](https://dashboard.lamdera.app/docs/download) 
