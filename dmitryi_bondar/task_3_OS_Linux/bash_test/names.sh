#!/bin/bash

#SOURCE=data1.txt  # if read from file
SOURCE="$1" # passing arg

while read -r line; do
    name="$line"
    echo "$name"
done < "$SOURCE"

