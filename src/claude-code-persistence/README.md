
# Claude Code Persistence (claude-code-persistence)

Opinionated Claude Code authentication, config and history persistence across a devcontainer instance

## Example Usage

```json
"features": {
    "ghcr.io/joshuanianji/devcontainer-features/claude-code-persistence:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|


## Opinionated Notes

This feature is meant to be used in conjunction with the [Token Monitor Agent feature](../token-monitor-agent/NOTES.md). The mount names and paths are standardized for the sake of internal consistency. 

I use this to persist sessions and authentication state across devcontainer restarts, as well as send token cost data to my central token monitoring hub.

## Changelog

| Version | Notes           |
| ------- | --------------- |
| 1.0.0   | Initial version |

## References

- [esimkowitz/claude-code-persistence](https://github.com/esimkowitz/devcontainer-features/tree/main/src/claude-code-persistence) — per-container alternative


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/joshuanianji/devcontainer-features/blob/main/src/claude-code-persistence/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
