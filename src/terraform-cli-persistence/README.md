
# Terraform CLI Persistence (terraform-cli-persistence)

Avoid extra logins from the Terraform CLI by preserving the `~/.terraform.d` folder across container instances.

## Example Usage

```json
"features": {
    "ghcr.io/joshuanianji/devcontainer-features/terraform-cli-persistence:1": {}
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

| Version | Notes                                           |
| ------- | ----------------------------------------------- |
| 1.0.2   | Move onCreate lifecycle script to `oncreate.sh` |
| 1.0.1   | Fix Docs                                        |
| 1.0.0   | Support zsh + refactor                          |
| 0.0.0   | Initial Version                                 |

## References

- [stuartleeks/azure-cli-persistence](https://github.com/stuartleeks/dev-container-features/tree/main/src/azure-cli-persistence)


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/joshuanianji/devcontainer-features/blob/main/src/terraform-cli-persistence/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
