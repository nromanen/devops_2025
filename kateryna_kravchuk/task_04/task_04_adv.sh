#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "Usage: $0 URL" >&2
    exit 1
fi

string="$1"

if [[ "$string" =~ ^https://.+ ]]; then
    echo "$string"
    exit 0
else
    echo "Error" >&2
    exit 1
fi