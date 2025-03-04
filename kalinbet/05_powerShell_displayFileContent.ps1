param (
 [string]$filePath
)

if (Test-Path $filePath) {
 Get-Content $filePath
} else {
 Write-Host "File does not exist"
}