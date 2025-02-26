#!/bin/bash

# Перевірка, чи передано аргументи
if [ $# -eq 0 ]; then
    echo "Usage: $0 <words separated by spaces>"
    exit 1
fi

# Перебираємо всі аргументи та виводимо кожен на новому рядку
for word in "$@"; do
    echo "$word"
done
