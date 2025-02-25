#!/bin/bash

FILE_PATH=task/user_data.txt
awk -F ', ' '{ print $4 }' $FILE_PATH | grep -E '^sudo.*org$'
