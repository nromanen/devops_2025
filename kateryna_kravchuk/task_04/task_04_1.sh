#!/usr/bin/env bash

# check if no arguments provided
if [ -z "$1" ]; then
    echo "Error: Empty parameter" >&2 # redirect to standard error output 
    exit 1
fi

# check if file exists
if [ ! -f "$1" ]; then
    echo "Error: File not found" >&2
    exit 1
fi

cat "$1"
