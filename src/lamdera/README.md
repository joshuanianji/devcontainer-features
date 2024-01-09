
# Lamdera (lamdera)

Installs [Lamdera](https://dashboard.lamdera.app/), a type-safe full-stack web-app platform for Elm (v1.1.0 and later).

## Example Usage

```json
"features": {
    "ghcr.io/joshuanianji/devcontainer-features/lamdera:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | Select or enter a Lamdera version. | string | latest |

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


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/joshuanianji/devcontainer-features/blob/main/src/lamdera/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
