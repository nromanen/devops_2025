#!/usr/bin/env pwsh
param (
    [string]$inputString
)

# Розділяємо рядок на окремі слова за допомогою пробіла
$words = $inputString -split ' '

# Виводимо кожне слово на новому рядку
foreach ($word in $words) {
    Write-Host $word
}
