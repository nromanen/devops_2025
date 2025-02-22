#!/usr/bin/env pwsh

# check if exactly one string provided
if ($args.Count -ne 1) {
    # get script's name to use in error message
    $scriptName = [System.IO.Path]::GetFileName($PSCommandPath)
    Write-Error "Usage: ./$scriptName '<string>'"
    exit 1
}

$input = $args[0]
$input -split " " | ForEach-Object { Write-Output $_ }
