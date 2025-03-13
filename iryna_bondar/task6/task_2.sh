#!/bin/bash

awk -F, '$4 ~ /^[^@]+@[^@%!\.]+\.com$/ && $5 !~ /[!#\$%&*+?@№:]/ {print $0}' ./user_data_task2.txt
