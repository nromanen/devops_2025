#!/bin/bash

FILE_PATH=task/user_data_task2.txt
EMAIL_REGEXP='^[[:alnum:]_+]+@[[:alnum:]]+.[a-z]{2,}$'
PASSWORD_REGEXP='[!№%:?]'

awk -F ', '   -v email_regexp="$EMAIL_REGEXP" -v passwd_regexp="$PASSWORD_REGEXP" ' { 
	if ($4 ~ email_regexp && $5 !~ passwd_regexp)
{ print "{\""$4 "\": \"" $2 "\047s password is " $5 ", it should be improved!\"}" }}' $FILE_PATH
