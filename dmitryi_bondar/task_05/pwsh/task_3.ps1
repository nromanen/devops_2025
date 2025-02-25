#!/usr/bin/env pwsh

0..4 | ForEach-Object {
    $filename = "file$_.txt"
    New-Item -Path '.' -Name $filename -ItemType File -Force | Out-Null
    $logMessage = "The file '$filename' has been created"
    Write-Output $logMessage
    Add-Content -Path "files.log" -Value $logMessage
}

Write-Output ""