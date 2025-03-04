# 1 part of Task 06  - 70 points

This command searches for lines whitch: 
contains emails in the file 'user_data.txt' that start with “sudo” and end with “.org”.    
- should be executed at folder where placed user_data.txt

```
$ grep -E '\bsudo.*@.*\.org\b' user_data.txt
```

# 2 part of Task 06 - 90 points
In the file 'user_data_task2.txt', identify all individuals who have a valid email address ending with 'com' and a weak password that lacks special characters such as ! № % : ?
- should be executed at folder where placed user_data2.txt

```
$ grep -E '^[^,]+,[^,]+,[^,]+,[^,]+@[^,]+\.com,([^!№%:?]+)$' user_data_task2.txt
```

# 3 part of Task 06 - 100 points
Based on the previous task's results, retrieve the name and password, and construct a sentence in the following format:
{"sudobobbsinnn@gmail.com" : "Bob's password is 12345, it should be improved!"}
- should be executed at folder where placed user_data2.txt

```
$ grep -E '^[^,]+,([^,]+),([^,]+),[^,]+@[^,]+\.com,([^!№%:?]+)$' user_data_task2.txt | while IFS=, read -r id first_name last_name email password; do   echo '{"'"$email"'" :"'"$first_name"'s password is '"$password"', it should be improved!"}'; done 
```