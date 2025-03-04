param (
    [string]$directory = "."
)

$logFilePath = "$directory\files.log"
if (Test-Path $logFilePath) {
	Remove-Item -Path $logFilePath -Force | Out-Null
}
New-Item -Path $logFilePath -ItemType File | Out-Null
foreach ($i in 0..4) {
	$filePath = "$directory\file$i.txt"
	if (Test-Path $filePath) {
		Remove-Item -Path $filePath -Force | Out-Null
	}
	New-Item -Path $filePath -ItemType File | Out-Null
	"The file 'file$i.txt' has been created" >> $logFilePath
}
"" >> $logFilePath

Get-Content $logFilePath