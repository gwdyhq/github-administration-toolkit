<#
.SYNOPSIS
    Replaces a literal or regex secret across history using git filter-repo.
    Usage:
      Literal: .\filter-repo-replace-string.ps1 "password=OldValue" "password=REDACTED"
      Regex:   .\filter-repo-replace-string.ps1 "regex:\b(AKIA[0-9A-Z]{16})\b" "AWS_KEY_REDACTED"
#>

param(
    [string]$From,
    [string]$To
)

if (-not $From -or -not $To) {
    Write-Host "Usage: .\filter-repo-replace-string.ps1 <from-string> <to-string>" -ForegroundColor Red
    exit 1
}

if (-not (Get-Command git-filter-repo -ErrorAction SilentlyContinue)) {
    Write-Host "git-filter-repo not found. Install with: pip install git-filter-repo" -ForegroundColor Red
    exit 1
}

$tmpFile = New-TemporaryFile
"$From==>$To" | Out-File -FilePath $tmpFile -Encoding UTF8 -NoNewline

git filter-repo --replace-text "$tmpFile"

Remove-Item $tmpFile -Force

Write-Host @"
Replaced content across history.
Next:
  git reflog expire --expire=now --all
  git gc --prune=now --aggressive
  git push origin --force --all
  git push origin --force --tags
"@