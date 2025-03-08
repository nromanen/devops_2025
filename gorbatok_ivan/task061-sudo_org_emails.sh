#!/bin/bash
echo "Enter the file name:"
read filename

if [[ ! -f "$filename" ]]; then
    echo "File not found!"
    exit 1
fi

echo "*********************************************************"
echo "Your file containes following sudo-org email addresses:"

grep -oE '\bsudo[a-zA-Z0-9._%+-]*@.*org\b' "$filename"

#я дуже хотів поубирати всі символи окрім крапки
# бо 9з10 імейл сервісів не пропустять такі юзернейми
