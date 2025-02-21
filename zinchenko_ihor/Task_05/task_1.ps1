#!/usr/bin/env pwsh
param (
    [string]$fileName
)

# Check if the file exists
if (Test-Path $fileName) {
    try {
        # Read and display file content
        Get-Content $fileName
    }
    catch {
        Write-Error "Failed to read file: $fileName. Error: $_"
    } 

    
} else {
    Write-Error "File not found: $fileName"   
}
