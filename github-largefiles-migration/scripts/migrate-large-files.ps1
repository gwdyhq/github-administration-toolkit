<#
.SYNOPSIS
    Rewrites history to store matching patterns in Git LFS.
    Usage: .\lfs-migrate.ps1 "*.zip,*.mp4,*.h5,*.tar.gz,*.bin"
#>

param(
    [string]$IncludePatterns = "*.zip,*.mp4,*.h5,*.tar.gz,*.bin"
)

Write-Host "Initializing Git LFS (idempotent)..." -ForegroundColor Cyan
git lfs install

Write-Host "Track and Commit Large files..." -ForegroundColor Cyan
git lfs track "*.zip *.mp4 *.h5 *.tar.gz *.bin"
git add .gitattributes
git commit -m "LFS tracking for large files"
git add path/to/large-file.zip
git commit -m "Add large files via LFS"

Write-Host "Verify..." -ForegroundColor Cyan
git lfs ls-files

Write-Host "Dry-run preview..." -ForegroundColor Yellow
git lfs migrate import --include="$IncludePatterns" --everything --dry-run

$ans = Read-Host "Proceed with actual migration? (yes/no)"
if ($ans -ne "yes") {
    Write-Host "Aborted." -ForegroundColor Red
    exit
}

git lfs migrate import --include="$IncludePatterns" --everything

Write-Host @"
History rewritten. Next steps:
  1) Temporarily disable branch protection on your target branch.
  2) git push origin --force --all
  3) git push origin --force --tags
  4) Re-enable branch protection and inform collaborators to re-clone/reset.
"@
