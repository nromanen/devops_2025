#!/usr/bin/env bash

log_file="log.log"

> "$log_file"

for i in {0..4}; do
    file_name="file${i}.txt"
    echo "This is file $i. $file_name" > "$file_name"
    echo "This is file $i. $file_name" >> "$log_file"
done

cat "$log_file"
