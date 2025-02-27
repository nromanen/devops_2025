#!/bin/bash

# Check if a parameter is provided
if [ -z "$1" ]; then
  echo "Error: No URL provided"
  exit 1
fi

# Regex to check if the URL starts with 'https://'
if [[ "$1" =~ ^https:// ]]; then
  echo "$1"
else
  echo "Error"
fi
