#!/bin/bash 

count=0
while [ $count -lt 5 ]; do
  echo "This is file $count. file$count.txt" >> log.log
  touch "file$count.txt"
  let count=$count+1
done

cat ./log.log
