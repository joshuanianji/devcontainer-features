
# Github CLI Persistence (github-cli-persistence)

Avoid extra logins from the Github CLI by preserving `~/.config/gh` folder across container instances.

## Example Usage

```json
"features": {
    "ghcr.io/joshuanianji/devcontainer-features/github-cli-persistence:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|


## Requirements

This feature assumes you have the `ghcr.io/devcontainers/features/github-cli` feature installed as well. 

## OS/Architecture Support

This Feature should work on recent versions of Debian/Ubuntu-based distributions. Github actions uses `amd` architecture to test it, but it should work with `arm` based architectures as well.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/joshuanianji/devcontainer-features/blob/main/src/github-cli-persistence/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
