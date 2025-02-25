#!/usr/bin/env pwsh

Param(
    [Parameter(Mandatory=$true)]
    [string]$get_args
)

$MainArray = $get_args -split '\s+' | ForEach-Object {
    $_
}
foreach ($get_args in $MainArray) {
    Write-Host $get_args
}