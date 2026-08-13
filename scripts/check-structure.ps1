$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)

$required = @(
  'SKILL.md','README.md','README.zh-CN.md','VERSION','LICENSE','CONTRIBUTING.md',
  'SECURITY.md','CODE_OF_CONDUCT.md','RELEASE_NOTES_v1.0.0.md','references/core/bug_catalog.yaml'
)
foreach ($item in $required) {
  if (-not (Test-Path (Join-Path $Root $item))) { throw "Missing required file: $item" }
}

if ((Get-Content (Join-Path $Root 'VERSION') -Raw).Trim() -ne '1.0.0') { throw 'Unexpected VERSION.' }

$skillLines = Get-Content (Join-Path $Root 'SKILL.md')
$skill = $skillLines -join "`n"
if ($skill -notmatch '(?m)^name: game-bug-tester$') { throw 'Missing portable skill name.' }
if ($skill -notmatch '(?m)^description:') { throw 'Missing skill description.' }
if ($skill -match '(?i)must (install|pip install|npm install)|required dependency: (airtest|poco|alttester)') {
  throw 'Potential mandatory dependency language found.'
}

$front = @()
$inside = $false
foreach ($line in $skillLines) {
  if ($line -eq '---') {
    if (-not $inside) { $inside = $true; continue }
    break
  }
  if ($inside -and $line -match '^([A-Za-z0-9_-]+):') { $front += $Matches[1] }
}
$front = @($front | Sort-Object)
if (($front -join ',') -ne 'description,name') { throw "Unexpected SKILL.md frontmatter keys: $($front -join ', ')" }

$catalog = Get-Content (Join-Path $Root 'references/core/bug_catalog.yaml')
$ids = @($catalog | Where-Object { $_ -match '^- id: ' } | ForEach-Object { $_ -replace '^- id: ', '' })
if ($ids.Count -ne 81) { throw "Expected 81 bug patterns, found $($ids.Count)." }
$dupes = $ids | Group-Object | Where-Object Count -gt 1
if ($dupes) { throw "Duplicate bug IDs found: $($dupes.Name -join ', ')" }

$py = @(Get-ChildItem $Root -Recurse -File -Filter *.py)
if ($py.Count -ne 0) { throw "Public zero-dependency release unexpectedly contains Python files: $($py.Count)" }

$stale = Get-ChildItem $Root -Recurse -File | Where-Object { $_.FullName -notmatch '\\.git\\' -and $_.Name -notin @('check-structure.sh','check-structure.ps1','PUBLIC_RELEASE_CHECK.txt') } | Select-String -Pattern '1\.0\.0-public|game-bug-tester-public' -ErrorAction SilentlyContinue
if ($stale) { throw 'Stale pre-release naming found.' }

Write-Host "Structure OK; version: 1.0.0; bug patterns: $($ids.Count); mandatory Python files: $($py.Count)"
