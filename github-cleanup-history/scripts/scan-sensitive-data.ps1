<#
.SYNOPSIS
    Naive scan of the entire Git history for common secret patterns.
#>

$patterns = @("password=", "aws_secret_access_key", "api_key", "token=", "PRIVATE KEY")

foreach ($p in $patterns) {
    Write-Host "=== Searching for pattern: $p ===" -ForegroundColor Cyan
    git rev-list --all | ForEach-Object {
        $rev = $_
        try {
            git grep -I -n "$p" $rev
        } catch {
            # ignore no matches
        }
    }
}
Write-Host "Scan complete (naive)." -ForegroundColor Green
Write-Host "For real projects, use gitleaks/trufflehog or GitHub secret scanning." -ForegroundColor Yellow