# repo-template

codingnanyong's standard starting point for new repos: Linear/GitHub-issue-gated PR flow, Claude + Codex PR review, Slack merge notifications, and the usual community-health files, all pre-wired.

## What's included

- `.github/workflows/pr-policy.yml` — every PR into `develop` must reference a paired Linear issue (`COD-n`) and a mirrored GitHub issue (`#n`); `main` only accepts PRs from `develop`. See [AGENTS.md](AGENTS.md#pr--issue-policy).
- `.github/workflows/claude-review.yml` — Claude automatically reviews every PR (needs setup, see below).
- `.github/workflows/notify-slack-on-merge.yml` — posts a summary to Slack when a PR merges into `develop`/`main`.
- `.github/workflows/create-linear-issue.yml` + `.github/scripts/create_linear_issue.py` — manually-triggered helper to create a Linear issue from the Actions tab.
- `AGENTS.md` / `CLAUDE.md` — agent role & rules (Claude reads `CLAUDE.md`, which imports `AGENTS.md`; Codex and other tools read `AGENTS.md` directly).
- `LICENSE` (MIT default — swap for an "All Rights Reserved" style notice if this is a content-only repo), `CODE_OF_CONDUCT.md`, `CONTRIBUTING.md`, `SECURITY.md`, `.github/pull_request_template.md`.

## Setup checklist for a new repo made from this template

1. **Rename things**: update this README, `AGENTS.md`'s "Project purpose" section, and the license year/holder if needed.
2. **Create `develop` branch**: `git checkout -b develop && git push -u origin develop`, then set `develop` as the default branch in repo Settings if that's your convention (or keep `main` default and just target `develop` for feature PRs).
3. **Install the Claude GitHub App**: https://github.com/apps/claude → select this repo.
4. **(Optional) Install a Codex review app** (e.g. ChatGPT Codex Connector) via https://github.com/settings/installations if you want a second automated reviewer.
5. **Add repo secrets** (Settings → Secrets and variables → Actions):
   - `CLAUDE_CODE_OAUTH_TOKEN` (run `claude setup-token` locally if you have a Claude subscription) or `ANTHROPIC_API_KEY`
   - `SLACK_WEBHOOK_URL` (Slack app → Incoming Webhooks, pick your notifications channel)
   - `LINEAR_API_KEY` (only needed if you'll use `create-linear-issue.yml`)
6. **Branch protection** (optional but recommended): require the `validate-flow` and `review` checks to pass before merging into `develop`/`main`.

For the full day-to-day procedure (creating the Linear/GitHub issue pair, branch naming, PR format), see [AGENTS.md](AGENTS.md#pr--issue-policy) or [CONTRIBUTING.md](CONTRIBUTING.md).
