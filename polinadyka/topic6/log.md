
## 1: Extracting Emails That Start with "sudo" and End with "org"

```bash
grep -Eo '\bsudo[a-zA-Z0-9._%+-]*@[^ ]*\.org\b' user_data.txt
```

**Output:**
```
sudo_david+-millersell@ya2hoo.org
sudojamesanderson@hotmaI_l.org
sudonoah_+scott@yahoo.org
```

---

## 2: Identifying Users with a ".com" Email and a Weak Password

```bash
awk -F', ' '$4 ~ /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.com$/ && $4 !~ /\.\./ && $5 ~ /^[a-zA-Z0-9]+$/ {print $2, $3, "-", $4, "-", $5}' user_data_task2.txt
```

**Output:**
```
Bob Sinkler - sudobobbsinnn@gmail.com - 12345
Sarah Williams - sarahwills@gmail.com - 98765
Emily Davis - emilydavis@gmail.com - 87654
```

---

## 3: Formatting as JSON Key-Value Pairs

```bash
awk -F', ' '$4 ~ /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.com$/ && $4 !~ /\.\./ && $5 ~ /^[a-zA-Z0-9]+$/ {printf "{\042%s\042 : \042%s'\''s password is %s, it should be improved!\042}\n", $4, $2, $5}' user_data_task2.txt
```

**Output:**
```
{"sudobobbsinnn@gmail.com" : "Bob's password is 12345, it should be improved!"}
{"sarahwills@gmail.com" : "Sarah's password is 98765, it should be improved!"}
{"emilydavis@gmail.com" : "Emily's password is 87654, it should be improved!"}
```

---

Screanshots : https://drive.google.com/drive/folders/19wpsd3d0fx-Lyqv3__w-oeUZ-szEWij3?usp=sharing