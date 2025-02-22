#!/usr/bin/env pwsh

# check if no args provided
if ($args.Count -eq 0) {
    # get script's name to use in the error message
    $scriptName = [System.IO.Path]::GetFileName($PSCommandPath)
    Write-Error "Usage: ./$scriptName <paths_file>"
    exit 1
}

$paths_file = $args[0]
# ensure that file exists
if (Test-Path $paths_file) {
    # open & print out content
    Get-Content $paths_file
} else {
    Write-Error "File not found: $paths_file"
    exit 1
}
