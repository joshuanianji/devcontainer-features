
# Google Cloud CLI Persistence (gcloud-cli-persistence)

Avoid extra logins from the Google Cloud CLI by preserving the `~/.config/gcloud` folder across container instances.

## Example Usage

```json
"features": {
    "ghcr.io/joshuanianji/devcontainer-features/gcloud-cli-persistence:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|


## OS and Architecture Support

Architectures: `amd` and `arm`.
OS: `ubuntu`, `debian`
Shells: `bash`, `zsh`, `fish`

## Changelog

| Version | Notes                  |
| ------- | ---------------------- |
| 1.0.0   | Support zsh + refactor |
| 0.0.0   | Initial Version        |


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/joshuanianji/devcontainer-features/blob/main/src/gcloud-cli-persistence/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
