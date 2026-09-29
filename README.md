# repo-template

codingnanyong's standard starting point for new repos: Linear/GitHub-issue-gated PR flow, Claude + Codex PR review, Slack merge notifications, and the usual community-health files, all pre-wired.

Creating a repository from this template? Start with the
[`shared-project-bootstrap.md`](templates/shared-project-bootstrap.md)
checklist before implementing product features.

## What's included

- `.github/workflows/prepare-feature-pr.yml` + `.github/scripts/ensure_linear_issue.py` — push a `feat/<slug>` branch and this finds-or-creates the Linear issue, finds-or-creates the mirrored GitHub issue, and opens a Draft PR into `develop` with both closing references already filled in. No manual issue-pairing steps.
- `.github/workflows/pr-policy.yml` — every PR into `develop` must reference a paired Linear issue (`COD-n`) and a mirrored GitHub issue (`#n`); `main` only accepts PRs from `develop`. Validates only — the provisioning above does the creating. See [AGENTS.md](AGENTS.md#pr--issue-policy).
- `.github/workflows/claude-review.yml` — Claude automatically reviews every PR (needs setup, see below).
- `.github/workflows/notify-slack-on-merge.yml` — posts a summary to Slack when a PR merges into `develop`/`main`.
- `AGENTS.md` / `CLAUDE.md` — agent role & rules (Claude reads `CLAUDE.md`, which imports `AGENTS.md`; Codex and other tools read `AGENTS.md` directly).
- `skills/`, `agents/`, `commands/`, `hooks/`, and `rules/` — tool-neutral capabilities shared by Claude and Codex.
- `templates/shared-handoff.md` — temporary coordination record for work that moves between Claude and Codex; durable decisions stay in `docs/`.
- `assets/images/source/`, `generated/`, and `final/` — reference inputs, working image outputs, and production-ready visual assets kept separate.
- `LICENSE` (MIT default — swap for an "All Rights Reserved" style notice if this is a content-only repo), `CODE_OF_CONDUCT.md`, `CONTRIBUTING.md`, `SECURITY.md`, `.github/pull_request_template.md`.
- `docs/kor/shared-git-workflow.md` / `docs/eng/shared-git-workflow.md` — human-readable branch/PR/Linear policy (same policy `AGENTS.md` and `pr-policy.yml` enforce, written out for people).
- `docs/kor/shared-ai-workspace.md` / `docs/eng/shared-ai-workspace.md` — detailed folder responsibilities, ownership prefixes, and Claude/Codex workflows.

## Setup checklist for a new repo made from this template

Everything below is a **one-time, per-repo** step — things only a human can do or decide (create accounts/keys, name the project, click "Install"). Once done, day-to-day PR/issue/Slack work is fully automated; nobody touches these again unless a key rotates or the project is renamed.

### A. What stays automated after setup (no action needed once wired up)

- Opening a `feat/<slug>` branch → Linear issue created/reused, GitHub mirror issue created/reused, Draft PR opened into `develop` — all handled by `prepare-feature-pr.yml`.
- Every PR event → branch/title/body/issue-pair validated by `pr-policy.yml`; nothing to fill in by hand.
- Merge into `develop` → mirrored GitHub issue auto-closed by `pr-policy.yml`, which auto-transitions the Linear issue to Done via Linear's own GitHub integration.
- Every PR → reviewed by `claude-review.yml` (and Codex, if installed).
- Merge into `develop`/`main` → summary posted to Slack by `notify-slack-on-merge.yml`.

### B. What you must newly do or provide for *this* repo

1. **Run the bootstrap checklist**: work through
   [`templates/shared-project-bootstrap.md`](templates/shared-project-bootstrap.md),
   including project identity, maintainer contacts, ownership prefixes, and
   removal of unused capabilities.
2. **Create `develop` branch**: `git checkout -b develop && git push -u origin develop`, then set `develop` as the default branch in repo Settings if that's your convention (or keep `main` default and just target `develop` for feature PRs).
3. **Install the Claude GitHub App**: https://github.com/apps/claude → select this repo.
4. **(Optional) Install a Codex review app** (e.g. ChatGPT Codex Connector) via https://github.com/settings/installations if you want a second automated reviewer.
5. **Add repo secrets** (Settings → Secrets and variables → Actions → Secrets) — these are credentials only you can issue:
   - `CLAUDE_CODE_OAUTH_TOKEN` (run `claude setup-token` locally if you have a Claude subscription) or `ANTHROPIC_API_KEY`
   - `SLACK_WEBHOOK_URL` (Slack app → Incoming Webhooks, pick your notifications channel)
   - `LINEAR_API_KEY` (Linear → Settings → API → Create key)
   - `GH_PAT` — a fine-grained PAT (Contents:read, Issues:write, Pull requests:write on this repo), **not** the default `GITHUB_TOKEN`. `prepare-feature-pr.yml` uses it to create the draft PR; PRs created with `GITHUB_TOKEN` don't retrigger `pr-policy.yml` (GitHub's anti-recursion rule), so the PR would stay unchecked.
6. **Add repo variables** (Settings → Secrets and variables → Actions → Variables) — the Linear project this repo's issues live in, since that's different per repo:
   - `LINEAR_PROJECT_SLUG` — from the Linear project's "Copy link" (the last URL segment)
   - `LINEAR_PROJECT_NAME` — the project's display name, used as a fallback lookup if the slug ever changes
7. **Branch protection** (optional but recommended): require the `validate-flow` and `review` checks to pass before merging into `develop`/`main`.

### C. Template invariants to preserve

- Keep shared capabilities at the repository root, not under `.claude/` or
  another tool-owned directory.
- Prefix capability files or directories with `shared-`, `claude-`, or
  `codex-`; keep required names such as `README.md` and `SKILL.md` unchanged.
- Keep `AGENTS.md` as the shared contract and `CLAUDE.md` as Claude's thin entry
  point.
- Keep `templates/shared-handoff.md` in the idle state when no continuation is
  active.
- Update automation, human documentation, and agent instructions together when
  branch, issue, or release policy changes.

Steps 5–6 are the only inputs the automation actually needs; everything after that (A above) runs itself. For the full day-to-day procedure and manual fallback if a secret expires, see [AGENTS.md](AGENTS.md#pr--issue-policy) or [CONTRIBUTING.md](CONTRIBUTING.md).

## Claude + Codex workspace

The collaboration contract lives in [`AGENTS.md`](AGENTS.md#collaboration-model).
Shared components are separated by function at the repository root rather than
nested under one tool. Claude owns documentation quality, Codex owns image
quality, and implementation and review are shared. Claude and Codex both read
the root capability folders through `CLAUDE.md` and `AGENTS.md`.

```text
repo-template/
├── skills/                           # reusable workflows by capability
│   ├── claude-documentation/         # Claude-only documentation workflow
│   ├── codex-image-assets/           # Codex-only image workflow
│   └── shared-implementation/        # Claude and Codex
├── agents/                           # tool-neutral role definitions
│   ├── claude-documentation-writer.md
│   ├── codex-image-creator.md
│   ├── shared-implementation.md
│   └── shared-code-reviewer.md
├── commands/shared-handoff.md        # shared handoff procedure
├── hooks/                            # shared executable safeguards
├── plugins/                          # shared plugin inventory
├── rules/                            # documentation, image, implementation rules
├── output-styles/                    # shared response conventions
├── statusline/                       # reusable status line scripts
├── templates/shared-handoff.md       # active cross-tool state template
├── .claude/settings.json             # Claude-only runtime wiring
├── AGENTS.md                         # shared Claude/Codex contract
├── CLAUDE.md                         # Claude entry point
├── CLAUDE.local.example.md           # ignored override template
├── .mcp.json                         # project MCP servers; root only
└── assets/images/
    ├── source/                       # supplied or external references
    ├── generated/                    # generated/editable working assets
    └── final/                        # optimized production assets
```

For mixed work, the current owner records unresolved cross-tool work in
[`templates/shared-handoff.md`](templates/shared-handoff.md) with exact paths and acceptance
criteria. Add MCP servers only to the root `.mcp.json`.

The root folders have intentionally different responsibilities:

- `skills/` describe **how to perform** reusable work.
- `agents/` describe **which role and judgment** to apply.
- `rules/` define **what the result must satisfy**.
- `commands/` define **when and how to start** repeated coordination flows.
- `templates/` contains reusable coordination templates and temporary handoff state.

Every capability name declares its ownership scope:

- `shared-<name>`: Claude and Codex can both use it; this is the default.
- `claude-<name>`: Claude-only.
- `codex-<name>`: Codex-only.

For skills and plugins, the directory carries the prefix while required files
such as `SKILL.md`, `README.md`, and manifests keep their standard names.

See the detailed workspace guide in
[Korean](docs/kor/shared-ai-workspace.md) or
[English](docs/eng/shared-ai-workspace.md).
