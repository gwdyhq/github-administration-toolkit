<#
.SYNOPSIS
    Creates a small binary-like file to demonstrate LFS tracking.
    Output: assets\dummy-large-file.bin (~256 KB)
#>

$assetsDir = Join-Path $PSScriptRoot "..\assets"
if (-not (Test-Path $assetsDir)) {
    New-Item -ItemType Directory -Path $assetsDir | Out-Null
}

$outFile = Join-Path $assetsDir "dummy-large-file.bin"
# Create ~256KB of random data
$bytes = New-Object byte[] (256KB)
[System.Random]::new().NextBytes($bytes)
[System.IO.File]::WriteAllBytes($outFile, $bytes)

Write-Host "Created $outFile (simulated large-ish binary)." -ForegroundColor Green
Write-Host "Add/commit to see LFS in action."
