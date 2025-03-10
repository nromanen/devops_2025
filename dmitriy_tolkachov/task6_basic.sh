#!/bin/bash
grep -Eo '\bsudo[a-zA-Z0-9._+-]+@[a-zA-Z0-9.-]+\.org\b' user_data.txt > emails.txt
echo "Results saved in emails.txt"
