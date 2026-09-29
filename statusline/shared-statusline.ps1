# Shared project status line.
$payload = [Console]::In.ReadToEnd() | ConvertFrom-Json
$cwd = [string]$payload.cwd
$model = [string]$payload.model.display_name
$used = $payload.context_window.used_percentage

$project = if ($cwd) { Split-Path $cwd -Leaf } else { 'project' }
$branch = ''
if ($cwd -and (Test-Path -LiteralPath $cwd)) {
    Push-Location -LiteralPath $cwd
    try { $branch = (git branch --show-current 2>$null) }
    finally { Pop-Location }
}

$parts = @($project)
if ($branch) { $parts += $branch }
if ($model) { $parts += $model }
if ($null -ne $used) { $parts += "ctx:$used%" }
Write-Output ($parts -join ' | ')
