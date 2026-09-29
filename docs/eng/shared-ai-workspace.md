# Shared Claude + Codex workspace and prefix rules

This document explains the purpose and use of the AI collaboration directories
at the repository root. Shared capabilities do not belong to either tool.
Claude and Codex enter through `CLAUDE.md` and `AGENTS.md`, then read the same
root directories directly.

## Principles

- `AGENTS.md` is the shared operating contract.
- `CLAUDE.md` is Claude's entry point and does not duplicate shared policy.
- Root `skills/`, `agents/`, `commands/`, and `rules/` are canonical.
- `.claude/` contains Claude Code runtime settings only.
- Claude leads documentation quality; Codex leads image quality.
- Either tool may implement code, tests, configuration, automation, and reviews.
- `templates/shared-handoff.md` stores active continuation state only. Durable decisions
  belong in `docs/` or code.

## Ownership prefixes

Files and child directories in capability folders declare their scope with a
prefix:

- `shared-<name>`: available to Claude and Codex; this is the default.
- `claude-<name>`: Claude-only behavior or responsibility.
- `codex-<name>`: Codex-only behavior or responsibility.

Ordinary files carry the prefix directly, such as
`rules/shared-payroll-review.md`. Skills and plugins put the prefix on their
directory, such as `skills/shared-release/SKILL.md`. `README.md`, `SKILL.md`,
`AGENTS.md`, `CLAUDE.md`, standard community files, dotfiles, and required
manifest names are exceptions.

## Directory reference

| Path | Purpose | Primary users | Change it when |
| --- | --- | --- | --- |
| `skills/` | Reusable procedures for completing work | Claude, Codex | A task type or standard procedure is added or changed |
| `agents/` | Role responsibilities and review perspectives | Claude, Codex | A responsibility or quality owner changes |
| `commands/` | User-triggered shared workflows | Claude, Codex | A repeated coordination flow needs an entry point |
| `rules/` | Constraints and quality requirements | Claude, Codex | An invariant for an artifact or work area changes |
| `hooks/` | Automatic command safeguards | Tool runtimes | A repeated check or dangerous action must be automated |
| `plugins/` | Project plugin inventory and setup rationale | Humans and agents | A plugin is introduced, replaced, or removed |
| `output-styles/` | Response and handoff presentation conventions | Claude, Codex | Reporting or communication conventions change |
| `statusline/` | Session status scripts | Tool runtimes | Displayed session data or runtime support changes |
| `templates/` | Reusable coordination templates and handoff state | Current and next owner | Another tool or session must continue the work |
| `assets/images/` | Image inputs, working files, and approved output | Primarily Codex | An image is supplied, generated, edited, or approved |
| `docs/` | Durable human-facing documentation | Primarily Claude | Policy, architecture, or usage guidance changes |
| `.claude/` | Claude Code runtime configuration | Claude Code | Runtime wiring or local configuration changes |
| `.github/` | GitHub Actions, PR templates, and automation | Shared | CI, PR policy, or notifications change |

## How the similar directories differ

- `skills/` explain how to perform a kind of work.
- `agents/` define the role and judgment used while performing it.
- `rules/` define constraints that the result must satisfy.
- `commands/` provide entry points for repeated coordination workflows.

Current skills route documentation to Claude, image assets to Codex, and
implementation to either tool. Current agents define documentation, image,
implementation, and review responsibilities.

## Workflows

### Documentation

Claude reads `skills/claude-documentation/SKILL.md`, applies
`agents/claude-documentation-writer.md` and `rules/shared-documentation.md`, verifies the
implementation, and updates the existing canonical document. Image requirements
go to Codex through `templates/shared-handoff.md`.

### Images

Codex reads `skills/codex-image-assets/SKILL.md`, applies
`agents/codex-image-creator.md` and `rules/shared-image-assets.md`, and moves assets through `assets/images/source/`,
`generated/`, and `final/`. Documentation or copy work goes to Claude through
the active handoff.

### Shared implementation

The active tool reads `skills/shared-implementation/SKILL.md` and
`templates/shared-handoff.md`, applies `agents/shared-implementation.md` and
`rules/shared-implementation.md`, implements and
tests the change, and updates the handoff only if another tool must continue.

## Handoffs

`templates/shared-handoff.md` should contain only actionable continuation state: goal,
current and next owner, decisions, exact paths, completed checks, next actions,
and remaining review. Do not store chat transcripts or durable architecture in
it. Reset it to `idle` after the handoff has been consumed.

## Adding a capability

1. Add `skills/<prefix>-<capability>/SKILL.md` when a reusable procedure is needed.
2. Add `agents/<prefix>-<role>.md` when the work needs a distinct responsibility.
3. Add `rules/<prefix>-<area>.md` for non-negotiable constraints.
4. Add `commands/<prefix>-<command>.md` for a repeated entry point.
5. Update the routing in `AGENTS.md` and the directory table in this document.
6. Do not duplicate shared content under `.claude/` or another tool directory.

## Related documents

- Shared contract: [`AGENTS.md`](../../AGENTS.md)
- Claude entry point: [`CLAUDE.md`](../../CLAUDE.md)
- Git and PR workflow: [`shared-git-workflow.md`](shared-git-workflow.md)
- Active handoff: [`templates/shared-handoff.md`](../../templates/shared-handoff.md)
- New-project bootstrap:
  [`shared-project-bootstrap.md`](../../templates/shared-project-bootstrap.md)
