#!/usr/bin/env bash
if [ -z "$1" ]; then
    echo "Error: Empty parameter" >&2
    exit 1
fi

for i in "$@"; do # for every argument of all
   printf "%s\n" "$i"
done
