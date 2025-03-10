#!/bin/bash

awk -F', ' '$4 ~ /\.com$/ && $5 !~ /[!№%:?]/ {print $4, $2, $5}' user_data_task2.txt > emails.txt

echo "Results saved in emails.txt"
