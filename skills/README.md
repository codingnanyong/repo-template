# Skills

Each skill lives in a prefixed directory and keeps the required entry filename
`SKILL.md` unchanged.

- `shared-<name>/SKILL.md`: available to Claude and Codex
- `claude-<name>/SKILL.md`: Claude-only workflow
- `codex-<name>/SKILL.md`: Codex-only workflow

Current skills route documentation to Claude, image assets to Codex, and
implementation to either tool.
