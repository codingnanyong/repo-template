# Project Rules

<!-- Fill this in for the actual project: what this repo is, who it's for,
what "done" looks like. Delete this comment once customized. -->

## Project purpose

TODO: one paragraph on what this repo is and its intended output.

## PR & issue policy

Every PR into `develop` is gated by CI (`.github/workflows/pr-policy.yml`) that requires a mirrored Linear/GitHub issue pair. Follow this exactly before opening a branch or PR:

1. Create a Linear issue in team `COD`, in the appropriate project.
2. Create a mirrored GitHub issue in this repo titled `COD-<n> <same title>` (`gh issue create`). There is no automatic Linear→GitHub mirroring; do this manually every time (or via `.github/workflows/create-linear-issue.yml` for the Linear side, then mirror the GitHub issue yourself).
3. Branch: `feat/cod-<n>-<slug>` (must match `^feat/[a-z0-9]+-[0-9]+-[a-z0-9-]+$`).
4. PR → base `develop`. Title starts with `COD-<n>`. Body must contain both `Closes COD-<n>` and `Closes #<github-issue-number>`, and the referenced GitHub issue's title must start with the same `COD-<n>`. A PR missing any of this fails CI immediately.
5. `main` only accepts PRs from `develop`. If this project cuts versioned releases, uncomment `validate-release` in `pr-policy.yml` and adapt it (see `codingnanyong/busan-competition-2026` for a working example); otherwise leave `main` PRs release-gate-free.

On merge into `develop`, CI auto-closes the mirrored GitHub issue; Linear's native GitHub integration then auto-transitions the Linear issue to Done. No manual status update needed after merge.

## Editing constraints

- Do not publish, upload, create a pull request, merge branches, or message external services without explicit user authorization (opening a PR as part of the normal Linear/GitHub flow above is fine; merging and any external-facing action still needs a go-ahead).
- Keep unrelated user changes intact.
- At handoff, report the changed files, any generated assets, and remaining review items.

<!-- Add project-specific sections here: coding style, test commands, domain
vocabulary, content voice, image/asset rules, etc. -->
