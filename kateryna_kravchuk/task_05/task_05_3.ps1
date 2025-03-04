#!/usr/bin/env pwsh

# specify log file & clear it
$log = "files.log"
Clear-Content -Path $log -ErrorAction SilentlyContinue

0..4 | ForEach-Object {
    $name = "file$_.txt"
    New-Item -Path $name -ItemType File -Force > $null 2>&1 # suppressing output
    "The file '$name' has been created" | Add-Content -Path $log
}

# add one line of white space
Add-Content -Path $log -Value ""

# print out logs
Get-Content -Path $log
