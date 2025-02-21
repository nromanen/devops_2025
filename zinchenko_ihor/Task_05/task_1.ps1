#!/usr/bin/env pwsh
param (
    [string]$fileName
)

# Перевіряємо, чи існує файл
if (Test-Path $fileName) {
    # Читаємо вміст файлу
    $fileContent = Get-Content $fileName

    # Виводимо вміст файлу
    $fileContent
} else {
    Write-Host "Файл не знайдений: $fileName"
}
