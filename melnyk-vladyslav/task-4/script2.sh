#!/usr/bin/env bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 <words>"
    exit 1
fi

for word in "$@"; do
    echo "$word"
done