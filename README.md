# Devcontainer Features

[![Tests](https://github.com/joshuanianji/devcontainer-features/actions/workflows/test.yaml/badge.svg)](https://github.com/joshuanianji/devcontainer-features/actions/workflows/test.yaml)

This repo contains my custom devcontainer features.

## Features

| Feature                                                      | Description                                                                                                     |
| ------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------- |
| [github-cli-persistence](./src/github-cli-persistence)       | Avoid extra logins from the Github CLI by preserving the `~/.config/gh` folder across container instances.      |
| [terraform-cli-persistence](./src/terraform-cli-persistence) | Avoid extra logins from the Terraform CLI by preserving the `~/.terraform.d` folder across container instances. |
