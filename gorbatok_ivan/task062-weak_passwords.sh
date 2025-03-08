#!/bin/bash
echo "Enter the file name:"
read filename

if [[ ! -f "$filename" ]]; then
    echo "File not found!"
    exit 1
fi

echo "*******************************************************************"
echo "Your file containes following emails addresses with weak passwords:"

grep -oP '^[^,]+, [^,]+, [^,]+, [^!-_+=@#$%,]+@[^,#$.%]+\.com, [a-zA-Z0-9]*$' "$filename"

#13 Liam Lewis не буде тому, що там дві коми в кінці адреси. 17 Lucas Hall також через %. 20 Harper Carter також.
