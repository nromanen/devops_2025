#!/bin/bash

log_file="log.log"

# Очищення файлу логу, якщо він існує
> $log_file

# Цикл для створення 5 файлів
for i in {0..4}; do
    file_name="file$i.txt"
    echo "This is file $i." > $file_name
    echo "This is file $i. $file_name" >> $log_file
done

# Вивід вмісту log.log
cat $log_file
