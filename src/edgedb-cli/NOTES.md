## Deprecation Notes

Please use [joshuanianji/gel-cli](https://github.com/joshuanianji/devcontainer-features/tree/main/src/gel-cli) instead. See: [EdgeDB is now Gel and Postgres is the Future](https://www.geldata.com/blog/edgedb-is-now-gel-and-postgres-is-the-future)

## Usage

**The EdgeDB instance should not be in the same container as the CLI.** My experience doing so makes the `edgedb ui` command start failing once you restart the container. I recommend the following options:

1. Use a docker-compose template with two services: one for the CLI and one for the EdgeDB instance.
    
    You can either use the [javascript-node-edgedb](https://github.com/joshuanianji/devcontainer-templates/blob/main/src/javascript-node-edgedb) or the [rust-edgedb](https://github.com/joshuanianji/devcontainer-templates/blob/main/src/rust-edgedb) templates, or use them as references to make your own.

    Once inside the devcontainer, you can run `edgedb instance link` to connect the CLI to the instance. Check the templates above for more details.

2. Connect to a cloud instance [with `edgedb cloud`](https://docs.edgedb.com/cloud/cli).

## Notes on Volume Mounts

This feature mounts the edgedb config and data folder for persistence. To do so, it makes some assumptions about `edgedb info`:

```bash
$ edgedb info

EdgeDB uses the following local paths:
┌────────────┬────────────────────────────────────────┐
│ Cache      │ /home/<user>/.cache/edgedb/            │
│ Config     │ /home/<user>/.config/edgedb/           │
│ CLI Binary │ /home/<user>/.local/bin/edgedb         │
│ Data       │ /home/<user>/.local/share/edgedb/data/ │
│ Service    │ /home/<user>/.config/systemd/user/     │
└────────────┴────────────────────────────────────────┘
```

**These paths may change based on the OS!** This feature is tested on Ubuntu and Debian and the paths match up, but may not work for others.

## OS and Architecture Support

Architectures: `amd` and `arm`

OS: `ubuntu`, `debian`

Shells: `bash`, `zsh`, `fish`

## Changelog

| Version | Notes                      |
| ------- | -------------------------- |
| 1.0.2   | Cache edgedb config folder |
| 1.0.1   | Fix for non-root users     |
| 1.0.0   | Initial Version            |
