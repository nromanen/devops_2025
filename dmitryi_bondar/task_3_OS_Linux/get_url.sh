: << 'COMMENT'
Write a script that takes a string as a parameter,
checks if it represents a URL that uses the HTTPS protocol,
and prints the URL to stdout; if it does not, the script prints the message Error in stdout.
COMMENT

#!/bin/bash

#checking if parameter is provided
if [ -z "$1" ]; then
  echo "Error: No URL" >&2
  exit 1
fi

#checking if URL is valid
if [[ $1 =~ ^https:// ]]; then
    echo "$1"
else
    echo "Error"
fi
