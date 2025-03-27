## Usage

**The Gel database instance should not be in the same container as the CLI.** My experience doing so makes the `gel ui` command start failing once you restart the container. I recommend the following options:

1. Use a docker-compose template with two services: one for the CLI and one for the Gel database instance.
    
    You can either use the [javascript-node-edgedb](https://github.com/joshuanianji/devcontainer-templates/blob/main/src/javascript-node-edgedb) or the [rust-edgedb](https://github.com/joshuanianji/devcontainer-templates/blob/main/src/rust-edgedb) templates, or use them as references to make your own.

    Once inside the devcontainer, you can run `gel instance link` to connect the CLI to the instance. Check the templates above for more details.

2. Connect to a cloud instance [with `gel cloud`](https://docs.edgedb.com/cloud/cli).

## Notes on Volume Mounts

This feature mounts the gel config and data folder for persistence. To do so, it makes some assumptions about `gel info`:

```bash
$ gel info

Gel uses the following local paths:
┌────────────┬────────────────────────────────────────┐
│ Cache      │ /home/<user>/.cache/gel/               │
│ Config     │ /home/<user>/.config/gel/              │
│ CLI Binary │ /home/<user>/.local/bin/gel            │
│ Data       │ /home/<user>/.local/share/gel/data/    │
│ Service    │ /home/<user>/.config/systemd/gel/      │
└────────────┴────────────────────────────────────────┘
```

**These paths may change based on the OS!** This feature is tested on Ubuntu and Debian and the paths match up, but may not work for others.

## OS and Architecture Support

Architectures: `amd` and `arm`

OS: `ubuntu`, `debian`

Shells: `bash`, `zsh`, `fish`

## Changelog

| Version | Notes                                 |
| ------- | ------------------------------------- |
| 1.0.0   | Initial Version (migrate from EdgeDB) |
