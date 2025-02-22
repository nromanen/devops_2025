#!/usr/bin/env bash

# create log file or clear it if existing
> log.log

for ((i=0; i<5; i++)) 
do
    filename="file${i}.txt"
    if [ ! -e "$filename" ]; then
        touch "$filename" # create file
    fi
    echo "This is file ${i}. $filename" >> log.log # append to log file
done

cat ./log.log
