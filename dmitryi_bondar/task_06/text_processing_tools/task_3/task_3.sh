#!/bin/bash

awk -F, '$4 ~ /^[^@]+@[a-zA-Z0-9.-]+\.[cC][oO][mM]$/ && $4 !~ /\.\./ && $5 !~ /[!#\$%&*+?@№:]/ {
  gsub(/ /, "", $2); gsub(/ /, "", $4); gsub(/ /, "", $5);
  printf "{\"%s\": \"%s''s password is %s, it should be improved!\"}\n", $4, $2, $5
}' user_data_task2.txt | jq -s 'add'