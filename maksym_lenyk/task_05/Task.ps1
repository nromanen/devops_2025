#!/usr/bin/env pwsh
# task 1 - Write a PowerShell script that takes the name of such a text file as an argument and shows its content.

param (
    [string]$fileName
)

if (Test-Path $fileName) {
    Get-Content $fileName
} else {
    Write-Host "The file '$fileName' does not exist."
}

#
# task 2 - Write a PowerShell script that takes arguments as a string of multiple words separated by spaces, and prints the words one per line.

param (
    [string]$inputString
)

$inputString.Split(' ') | ForEach-Object { Write-Host $_ }

#
#Task 3 - Write a PowerShell script that creates 5 text files named file followed by a file number starting from 0. For example, the files should be named file0.txt, file1.txt, and so on. Append a log message to a file named files.log for each file creation, stating that the file has been created, like The file ... has been created. Finally, output the contents of the files.log file.

for ($i = 0; $i -lt 5; $i++) {
    $fileName = "file$i.txt"
    New-Item -Path $fileName -ItemType File -Force | Out-Null
    
    $logMessage = "The file '$fileName' has been created"
    Add-Content -Path "files.log" -Value $logMessage
}

Get-Content -Path "files.log"
Write-Output ""