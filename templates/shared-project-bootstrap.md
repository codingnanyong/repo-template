# Shared project bootstrap checklist

Complete this checklist after creating a repository from the template. Delete
completed notes that should not become permanent project documentation, but keep
the checklist file for future template updates.

## 1. Project identity

- [ ] For the source template repository, enable **Template repository** in
      GitHub Settings so the **Use this template** action is available.
- [ ] Replace the project name and summary at the top of `README.md`.
- [ ] Replace the template description in `AGENTS.md` under **Project purpose**.
- [ ] Update the year and copyright holder in `LICENSE`.
- [ ] Review the maintainer and contribution policy in `CONTRIBUTING.md`.
- [ ] Replace the contact address in `CODE_OF_CONDUCT.md` and `SECURITY.md`.
- [ ] Remove template examples that do not apply to the new project.

## 2. Claude + Codex workspace

- [ ] Keep only the skills, agents, rules, commands, hooks, and templates the
      project will actually use.
- [ ] Name new capabilities with `shared-`, `claude-`, or `codex-`.
- [ ] Confirm every skill directory name matches its `SKILL.md` frontmatter
      `name` value.
- [ ] Reset `templates/shared-handoff.md` to `Status: idle`.
- [ ] Copy `CLAUDE.local.example.md` to ignored `CLAUDE.local.md` only when
      machine-specific Claude preferences are needed.
- [ ] Add project MCP servers to root `.mcp.json`; leave it empty when none are
      required.
- [ ] Review `.claude/settings.json` for operating-system compatibility before
      enabling the PowerShell hook and status line on non-Windows machines.

## 3. Repository automation

- [ ] Decide whether the project uses the `develop` integration branch and
      `feat/<slug>` feature branches. Update workflows and documentation
      together if the branch model changes.
- [ ] Replace the Linear team key `COD` everywhere if the project uses another
      team.
- [ ] Replace the Linear workspace segment `codingnanyong` in
      `.github/workflows/notify-slack-on-merge.yml` when applicable.
- [ ] Add `LINEAR_API_KEY`, `GH_PAT`, and the selected Claude credential in
      GitHub Actions secrets.
- [ ] Add `SLACK_WEBHOOK_URL` only when merge notifications remain enabled.
- [ ] Add `LINEAR_PROJECT_SLUG` and `LINEAR_PROJECT_NAME` as repository
      variables.
- [ ] Install and authorize the Claude GitHub App and any Codex review app used
      by the project.
- [ ] Configure branch protection for the checks the project keeps.
- [ ] Remove unused workflows and their corresponding secrets, variables, and
      README instructions.

## 4. Assets and documentation

- [ ] Put supplied image references in `assets/images/source/`, working images
      in `assets/images/generated/`, and approved images in
      `assets/images/final/`.
- [ ] Replace or remove the template Git and AI workspace documentation when the
      project adopts different policies.
- [ ] Keep Korean and English documentation synchronized when both are retained.

## 5. Verification

- [ ] Confirm all relative Markdown links resolve.
- [ ] Search for stale template values: `repo-template`, `codingnanyong`, `COD`,
      placeholder emails, and example repository names.
- [ ] Validate YAML, JSON, TOML, and executable hook syntax used by the project.
- [ ] Run `git diff --check` and the project's test, lint, and build commands.
- [ ] Confirm `templates/shared-handoff.md` contains no completed task state.
