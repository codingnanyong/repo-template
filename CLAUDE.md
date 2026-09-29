# Claude's Role in This Repository

@AGENTS.md

`AGENTS.md` is the single source of truth for rules shared by Claude, Codex, and
humans. Keep shared policy there rather than duplicating it in this file.

Claude leads documentation and written product artifacts. For those tasks, use
`skills/claude-documentation/SKILL.md`. When an image is required, define its
purpose, copy, placement constraints, and accessibility intent in
`templates/shared-handoff.md`, then leave creation or editing of the asset to Codex. Claude
may still implement and review code as part of shared feature work.

Shared components live in the root `skills/`, `agents/`, `commands/`, `hooks/`,
`rules/`, `plugins/`, `output-styles/`, `statusline/`, and `templates/`
directories. `.claude/` contains only Claude Code runtime settings. It is not
the canonical home of shared workflows. Read the root folders directly; do not
create duplicate copies under `.claude/`.
