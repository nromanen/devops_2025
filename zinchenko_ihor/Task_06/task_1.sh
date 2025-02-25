#!/bin/bash

# Вказуємо шлях до файлу user_data.txt
FILE="$HOME/devops_2025/zinchenko_ihor/Task_06/task/user_data.txt"

# Регулярний вираз для пошуку email-адрес
PATTERN="sudo[a-zA-Z0-9._%+-]*@[a-zA-Z0-9._-]+\.org"

# Файл для збереження результатів
OUTPUT_FILE="found_emails.txt"

# Перевіряємо, чи існує файл
if [[ ! -f "$FILE" ]]; then
    echo "Error: File $FILE not found!"
    exit 1
fi

# Виконуємо пошук email-адрес і записуємо у файл
grep -E "$PATTERN" "$FILE" > "$OUTPUT_FILE"

# Перевіряємо, чи знайдено результати
if [[ -s "$OUTPUT_FILE" ]]; then
    echo "Emails found and saved in $OUTPUT_FILE:"
    cat "$OUTPUT_FILE"  # Виводимо вміст знайдених email-ів у консоль
else
    echo "No matching emails found."
    rm "$OUTPUT_FILE"  # Видаляємо порожній файл
fi

