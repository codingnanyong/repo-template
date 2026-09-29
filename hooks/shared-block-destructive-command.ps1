# Shared Claude/Codex command safety hook.
$callInput = [Console]::In.ReadToEnd() | ConvertFrom-Json
$command = [string]$callInput.tool_input.command

$dangerousPatterns = @(
    '(?i)\brm\s+[^\r\n]*-[^\r\n]*r[^\r\n]*f',
    '(?i)\bRemove-Item\b[^\r\n]*(?:-Recurse[^\r\n]*-Force|-Force[^\r\n]*-Recurse)',
    '(?i)\bgit\s+(?:push\s+[^\r\n]*--force|reset\s+--hard|clean\s+-[^\r\n]*f)'
)

$blocked = $dangerousPatterns | Where-Object { $command -match $_ } | Select-Object -First 1

if ($blocked) {
    @{
        hookSpecificOutput = @{
            hookEventName = 'PreToolUse'
            permissionDecision = 'deny'
            permissionDecisionReason = 'Destructive command blocked by the repository safety hook.'
        }
    } | ConvertTo-Json -Depth 4 -Compress
}
