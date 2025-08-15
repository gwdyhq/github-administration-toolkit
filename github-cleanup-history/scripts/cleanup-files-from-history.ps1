<#
.SYNOPSIS
    Removes a file from the entire history using git filter-repo.
    Usage: .\filter-repo-remove-file.ps1 path\to\file
#>

param(
    [string]$TargetPath
)

if (-not $TargetPath) {
    Write-Host "Usage: .\filter-repo-remove-file.ps1 <path-to-remove>" -ForegroundColor Red
    exit 1
}

if (-not (Get-Command git-filter-repo -ErrorAction SilentlyContinue)) {
    Write-Host "git-filter-repo not found. Install with: pip install git-filter-repo" -ForegroundColor Red
    exit 1
}

git filter-repo --path "$TargetPath" --invert-paths

Write-Host @"
Removed '$TargetPath' from all history.
Next:
  git reflog expire --expire=now --all
  git gc --prune=now --aggressive
  git push origin --force --all
  git push origin --force --tags
"@