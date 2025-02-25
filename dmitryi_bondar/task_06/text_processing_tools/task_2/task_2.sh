#!/bin/bash


# awk -F',' '{email = $4; gsub(/^ +| +$/, "", email); pw = $5; gsub(/^ +| +$/, "", pw); if (email ~ /@.*com$/ && pw ~ /^[a-zA-Z0-9]+$/) print }' user_data_task2.txt

awk -F, '$4 ~ /^[^@]+@[^@%!\.]+\.com$/ && $5 !~ /[!#\$%&*+?@№:]/ {print $0}' ./user_data_task2.txt