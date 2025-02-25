# Basic Task 1
- used grep
`grep -E '\b[a-zA-Z0-9._+-]*@[^ ]+\.org\b' user_data.txt`
- used awk
`awk -F', ' '$4 ~ /^sudo[a-zA-Z0-9._+-]*@.*\.org$/ {print $4}' user_data.txt`
- used sed
`sed -nE 's/.*(sudo[a-zA-Z0-9._+-]*@[^ ]+\.org).*/\1/p' user_data.txt`
---
### result
```
sudo_david+-millersell@ya2hoo.org
sudojamesanderson@hotmaI_l.org
sudonoah_+scott@yahoo.org
```
## work on 90%
`grep -E ',\s*[^,]+@[a-zA-Z0-9.-]+\.com\s*,' user_data_task2.txt`
### result
```
1, Bob, Sinkler, sudobobbsinnn@gmail.com, 12345
2, Alice, Johnson, alicejohnson@gmail.com, Sunny$123%
3, Michael, Thompson, mthompson@hotmail.com, 54&321
4, Sarah, Williams, sarahwills@gmail.com, 98765
6, Emily, Davis, emilydavis@gmail.com, 87654
8, Olivia, Wilson, owilson@gmail.com, H@ppy#456
9, Benjamin, Roberts, broberts@yahoo.com, Eas!P@ss7#
10, Sophia, Taylor, sophiataylor@gmail.com, Cool#C@t99$
11, Ethan, Brown, ethanbrownsell@gmail.com, 13579Di!on
12, Emma, Clark, emmasudoclark@yahoo.com, 86420!
13, Liam, Lewis, liamlewis@hotmail..com, 97531
16, Mia, White, miawhite!!!@gmail.com, 35791
18, Isabella, Young, isabellayoung@gmail.com, 41953Boobi#
19, Oliver, Green, olivergreen@yahoo.com, L@zyD0g#44%
20, Harper, Carter, harpercarter@#$@gmail.com, 14362
```
`
grep -E ',\s*[^,]+@[a-zA-Z0-9.-]+\.com\s*,' user_data_task2.txt | awk -F', ' '$NF ~ /^[0-9]+$/ {print $2, $3, "-", $4}'
`
```
Bob Sinkler - sudobobbsinnn@gmail.com
Sarah Williams - sarahwills@gmail.com
Emily Davis - emilydavis@gmail.com
Liam Lewis - liamlewis@hotmail..com
Mia White - miawhite!!!@gmail.com
Harper Carter - harpercarter@#$@gmail.com
```
## work on 100%
` grep -E ',\s*[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}\s*,' user_data_task2.txt | grep -vE '@[^[:alnum:]]' | awk -F', ' '$NF ~ /^[0-9]+$/ {printf("{\"%s\" : \"%s'\''s password is %s, it should be improved!\"}\n", $4, $2, $NF)}'
`
```
{"sudobobbsinnn@gmail.com" : "Bob's password is 12345, it should be improved!"}
{"sarahwills@gmail.com" : "Sarah's password is 98765, it should be improved!"}
{"sudo_david+-millersell@ya2hoo.org" : "David's password is 23456, it should be improved!"}
{"emilydavis@gmail.com" : "Emily's password is 87654, it should be improved!"}
{"liamlewis@hotmail..com" : "Liam's password is 97531, it should be improved!"}
```
