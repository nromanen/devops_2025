#!/usr/bin/env pwsh

Param(
  [parameter(mandatory=$true)][string]$file
)

Get-Content "$file" | ForEach-Object {
    $task = $_
    $task
}
