#!/bin/bash

# Перевірка, чи було передано аргумент
if [ $# -eq 0 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

# Зберігаємо ім'я файлу в змінну
file=$1

# Перевіряємо, чи існує файл
if [ ! -f "$file" ]; then
    echo "File $file does not exist."
    exit 1
fi

# Виводимо вміст файлу
cat "$file"
