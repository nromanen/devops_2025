#!/usr/bin/env bash

# create log file or clear it if existing
> log.log

for ((i=0; i<5; i++)) 
do
    filename="file${i}.txt"

    touch "$filename" # create file or update timestamp if exists
    
    echo "This is file ${i}. $filename" >> log.log # append to log file
done

cat ./log.log
