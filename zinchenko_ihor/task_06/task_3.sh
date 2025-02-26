#!/bin/bash

# Файл з користувачами, які мають слабкі паролі
FILE="weak_passwords.txt"

# Файл для збереження результатів
OUTPUT_FILE="final_results.txt"

# Перевіряємо, чи існує файл
if [[ ! -f "$FILE" || ! -s "$FILE" ]]; then
    echo "Помилка: Файл $FILE не знайдено або він порожній!"
    exit 1
fi

# Записуємо відкриваючу фігурну дужку в JSON-файл
echo "{" > "$OUTPUT_FILE"

# Лічильник рядків
total_lines=$(wc -l < "$FILE")
line_number=0

# Читаємо файл рядок за рядком
while IFS=',' read -r id first_name last_name email password; do
    # Збільшуємо лічильник рядків
    ((line_number++))

    # Видаляємо зайві пробіли
    email=$(echo "$email" | xargs)
    first_name=$(echo "$first_name" | xargs)
    password=$(echo "$password" | xargs)

    # Додаємо запис у JSON
    echo -n "  \"$email\" : \"$first_name's password is $password, it should be improved!\"" >> "$OUTPUT_FILE"

    # Якщо це не останній рядок, то додаємо кому в кінці рядка
    if [[ $line_number -lt $total_lines ]]; then
        echo "," >> "$OUTPUT_FILE"
    else
        echo "" >> "$OUTPUT_FILE"
    fi

done < "$FILE"

# Записуємо закриваючу фігурну дужку
echo "}" >> "$OUTPUT_FILE"

# Виводимо результат
cat "$OUTPUT_FILE"
