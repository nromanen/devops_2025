###### Task 1
Using regular expressions and any of the tools like grep, sed, or awk, search for emails in the file 'user_data.txt' that start with 'sudo' and end with 'org'.

```bash
rezus@laptop:~/Desktop$ grep -E '\bsudo[^@]*@[^ ]*\.org\b' task/user_data.txt
5, David, Miller, sudo_david+-millersell@ya2hoo.org, 23456
7, James, Anderson, sudojamesanderson@hotmaI_l.org, 34567
15, Noah, Scott, sudonoah_+scott@yahoo.org, 90876
```

###### Task 2
In the file 'user_data_task2.txt', identify all individuals who have a valid email address ending with 'com' and a weak password that lacks special characters such as **! № % : ?**

```bash
rezus@laptop:~/Desktop$ awk -F', ' '$4 ~ /\.com$/ && $5 !~ /[!№%:?]/' task/user_data_task2.txt
1, Bob, Sinkler, sudobobbsinnn@gmail.com, 12345
3, Michael, Thompson, mthompson@hotmail.com, 54&321
4, Sarah, Williams, sarahwills@gmail.com, 98765
6, Emily, Davis, emilydavis@gmail.com, 87654
8, Olivia, Wilson, owilson@gmail.com, H@ppy#456
10, Sophia, Taylor, sophiataylor@gmail.com, Cool#C@t99$
13, Liam, Lewis, liamlewis@hotmail..com, 97531
16, Mia, White, miawhite!!!@gmail.com, 35791
17, Lucas, Hall, lucashall@%%hotmail.com, 68204
18, Isabella, Young, isabellayoung@gmail.com, 41953Boobi#
20, Harper, Carter, harpercarter@#$@gmail.com, 14362
```

###### Task 3
Based on the previous task's results, retrieve the name and password, and construct a sentence in the following format:

_{"sudobobbsinnn@gmail.com" : "Bob's password is 12345, it should be improved!"}_

```bash
rezus@laptop:~/Desktop$ awk -F', ' '$4 ~ /\.com$/ && $5 !~ /[!№%:?]/ {print "{\"" $4 "\": \"" $2 "\x27s password is " $5 ", it should be improved!\"}"}' task/user_data_task2.txt
{"sudobobbsinnn@gmail.com": "Bob's password is 12345, it should be improved!"}
{"mthompson@hotmail.com": "Michael's password is 54&321, it should be improved!"}
{"sarahwills@gmail.com": "Sarah's password is 98765, it should be improved!"}
{"emilydavis@gmail.com": "Emily's password is 87654, it should be improved!"}
{"owilson@gmail.com": "Olivia's password is H@ppy#456, it should be improved!"}
{"sophiataylor@gmail.com": "Sophia's password is Cool#C@t99$, it should be improved!"}
{"liamlewis@hotmail..com": "Liam's password is 97531, it should be improved!"}
{"miawhite!!!@gmail.com": "Mia's password is 35791, it should be improved!"}
{"lucashall@%%hotmail.com": "Lucas's password is 68204, it should be improved!"}
{"isabellayoung@gmail.com": "Isabella's password is 41953Boobi#, it should be improved!"}
{"harpercarter@#$@gmail.com": "Harper's password is 14362, it should be improved!"}
```