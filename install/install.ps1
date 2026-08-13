param(
  [Parameter(Mandatory=$true)]
  [ValidateSet('codex','claude','claude-code')]
  [string]$HostName,
  [string]$Project = '.'
)

$ErrorActionPreference = 'Stop'
$Root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path

if ($HostName -eq 'codex') {
  $Target = Join-Path $Project '.agents\skills\game-bug-tester'
} else {
  $Target = Join-Path $Project '.claude\skills\game-bug-tester'
}

if (Test-Path $Target) { throw "Target exists: $Target" }
New-Item -ItemType Directory -Force -Path $Target | Out-Null

Get-ChildItem -Force $Root |
  Where-Object { $_.Name -notin @('.git','.agents','.claude') } |
  ForEach-Object { Copy-Item -Recurse -Force $_.FullName $Target }

Write-Host "Installed Game Bug Tester to $Target"
Write-Host 'No packages, plugins, SDKs, or QA frameworks were installed.'
