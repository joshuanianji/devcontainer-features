# Devcontainer Features

[![Tests](https://github.com/joshuanianji/devcontainer-features/actions/workflows/test.yaml/badge.svg)](https://github.com/joshuanianji/devcontainer-features/actions/workflows/test.yaml)

This repo contains my custom devcontainer features.

## Features

| Feature                                                      | Description                                                                                                             |
| ------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------- |
| [github-cli-persistence](./src/github-cli-persistence)       | Avoid extra logins from the Github CLI by preserving the `~/.config/gh` folder across container instances.              |
| [terraform-cli-persistence](./src/terraform-cli-persistence) | Avoid extra logins from the Terraform CLI by preserving the `~/.terraform.d` folder across container instances.         |
| [aws-cli-persistence](./src/aws-cli-persistence)             | Avoid extra logins from the AWS CLI by preserving the `~/.aws` folder across container instances.                       |
| [lamdera](./src/lamdera)                                     | Installs [Lamdera](https://dashboard.lamdera.app/), a type-safe full-stack web-app platform for Elm (v1.1.0 and later). |
