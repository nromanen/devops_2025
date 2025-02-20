#!/bin/bash

# Вказуємо шлях до файлу з даними
FILE="$HOME/devops_2025/zinchenko_ihor/Task_06/task/user_data_task2.txt"


# Валідація email адрес, які вірні та закінчуються на '.com'та виявлення слабких паролів (без спецсимволів: ! № % : ?)
PATTERN="^[0-9]+, [^,]+, [^,]+, [a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.com, [a-zA-Z0-9]+$"

# Файл для збереження результатів
OUTPUT_FILE="weak_passwords.txt"

# Перевіряємо, чи існує файл
if [[ ! -f "$FILE" ]]; then
    echo "Error: File $FILE not found!"
    exit 1
fi

# Виконуємо пошук слабких паролів та зберігаємо у файл
grep -E "$PATTERN" "$FILE" > "$OUTPUT_FILE"

# Перевіряємо, чи знайдено результати
if [[ -s "$OUTPUT_FILE" ]]; then
    echo "Users with weak passwords saved in $OUTPUT_FILE:"
    cat "$OUTPUT_FILE"  # Виводимо результати у консоль
else
    echo "No weak passwords found."
    rm "$OUTPUT_FILE"  # Видаляємо порожній файл, якщо немає збігів
fi
