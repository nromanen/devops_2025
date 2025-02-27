param (
 [string]$inputString
)

$inputString -split '\s+' | ForEach-Object { Write-Host $_ }