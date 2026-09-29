# Hooks

Hooks are executable safeguards or automations called by a tool runtime. Prefix
scripts with `shared-`, `claude-`, or `codex-` based on their intended scope.
Tool-specific settings may point to a shared hook without copying it.

- `shared-block-destructive-command.ps1`: rejects destructive shell commands
