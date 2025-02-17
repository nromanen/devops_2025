#!/usr/bin/env bash
if [ $# -eq 0 ]; then
    echo "Error: No URL provided."
    exit 1
fi

url=$1

if [[ "$url" =~ ^https:// ]]; then
    echo "$url"
else
    echo "Error"
fi