<#
.SYNOPSIS
    Lists the largest 50 blobs across the entire Git history.
#>

git rev-list --objects --all |
    ForEach-Object {
        $line = $_
        $typeInfo = git cat-file --batch-check="$line" --batch-all-objects
        $parts = $typeInfo -split '\s+'
        if ($parts[0] -eq 'blob') {
            # Size, SHA, Filename
            "$($parts[2]) $($parts[1]) $($parts[3])"
        }
    } |
    Sort-Object { [int]($_ -split ' ')[0] } -Descending |
    Select-Object -First 50
