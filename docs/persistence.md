# Persistence suite — operational notes

Shared operational details for the `*-persistence` features in this collection
(`claude-code-persistence`, `opencode-persistence`). Per-feature specifics live in
each feature's NOTES.md.

## Compose caveat (verified with @devcontainers/cli 0.87.0)

Docker Compose prefixes feature-declared volume names with the compose project
name: a `dockerComposeFile` devcontainer with project `foo_devcontainer` gets
`foo_devcontainer_claude-code-config` instead of the shared `claude-code-config`.
Consequences:

- **Image/dockerfile devcontainers**: mount the bare names — true sharing, one
  login everywhere. This is the primary use case with user-level
  `dev.containers.defaultFeatures`.
- **Compose devcontainers**: get a deterministic project-prefixed copy per
  project — same effective behavior as per-container persistence features, and
  existing prefixed volumes (e.g. `jiki_devcontainer_claude-code-config`) are
  inherited as-is, no migration needed.

To force true sharing in a compose repo, pin the names in its `compose.yml`
(teammates simply get locally-created volumes — no failure, no secrets):

```yaml
volumes:
  claude-code-config:
    name: claude-code-config
  opencode-data:
    name: opencode-data
  opencode-config:
    name: opencode-config
```

## Migrating existing data

Claude Code (`~/.claude` or a previous container's volume):

```sh
docker run --rm -v claude-code-config:/dc/claude -v ~/.claude:/from alpine \
    sh -c 'cp -a /from/. /dc/claude/ && chown -R 1000:1000 /dc/claude'
```

OpenCode (`~/.local/share/opencode` + `~/.config/opencode`):

```sh
docker run --rm \
    -v opencode-data:/dc/data -v opencode-config:/dc/config \
    -v ~/.local/share/opencode:/from-data -v ~/.config/opencode:/from-config \
    alpine sh -c 'cp -a /from-data/. /dc/data/ && cp -a /from-config/. /dc/config/ && \
        chown -R 1000:1000 /dc/data /dc/config'
```

Adjust uid (`1000`) to the target image's remote user when it differs from `node`.
