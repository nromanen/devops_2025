#!/usr/bin/env pwsh

# Видаляємо файл files.log, якщо він існує, перед початком роботи
if (Test-Path "files.log") {
    Remove-Item "files.log"
}

# Створюємо 5 текстових файлів і записуємо процес їх створення в журнал
for ($i = 0; $i -lt 5; $i++) {
    $fileName = "file$i.txt"
    
    # Створюємо файл
    New-Item -Path $fileName -ItemType "File" -Force | Out-Null

    # Записуємо повідомлення про створення файлу, використовуючи одинарні лапки навколо імені файлу
    $logMessage = "The file '$fileName' has been created"
    $logMessage | Out-File -Append -FilePath "files.log"
}

# Виводимо вміст файлу files.log
Get-Content -Path "files.log"

# Додаємо порожній рядок після виведення вмісту файлу
Write-Host ""
