

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
