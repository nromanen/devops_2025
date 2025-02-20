#!/bin/bash

# Вказуємо шлях до файлу з результатами пошуку слабких паролів
FILE="weak_passwords.txt"

# Файл для збереження фінальних результатів
OUTPUT_FILE="final_results.txt"

# Перевіряємо, чи існує файл
if [[ ! -f "$FILE" ]]; then
    echo "Error: File $FILE not found!" 
    exit 1
fi

# Створюємо порожній файл для фінальних результатів
echo "" > "$OUTPUT_FILE"

# Перебираємо кожен рядок з файлу з слабкими паролями
while IFS=',' read -r id first_name last_name email password; do
    # Формуємо фінальне речення
    echo "\"$email\" : \"$first_name's password is $password, it should be improved!\"" >> "$OUTPUT_FILE"
done < "$FILE"

# Виводимо результат в консоль
cat "$OUTPUT_FILE"
