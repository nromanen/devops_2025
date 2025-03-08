#!/bin/bash
echo "Enter the file name:"
read filename

if [[ ! -f "$filename" ]]; then
    echo "File not found!"
    exit 1
fi

grep -oP '^[^,]+, [^,]+, [^,]+, [^!-_+=@#$%,]+@[^,.#$_%]+\.[a-z]*, [a-zA-Z0-9]*$' "$filename" | while IFS=',' read -r id first_name last_name email password; do
    echo "{\"$email\" : \"$first_name's password is $password, it should be improved!\"}"

done

#використав [a-z] заміть com щоб підтянути і .орг адреси, але вони з помилками:(
