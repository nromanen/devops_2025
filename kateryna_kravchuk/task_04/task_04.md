# Task 04: Bash Scripting

>Done by [@Lians-coder](https://github.com/Lians-coder) (Kateryna Kravchuk)

## Simple problems

### Problem 1

#### Task

Suppose we have a text file that contains some file names, for example:  
`jobe  `  
`/var/www/html/index.html`  
`/var/www/html/jobe`  
Write a shell script that takes the name of such a text file as an argument and shows its content.  

*For example:*  

| Test | Input | Result |
| --- | --- | --- |
| \# Test 1 | data1.txt | jobe  |
|  |  | /var/www/html/index.html | 
| | | /var/www/html/jobe |

#### Solution  

```bash
#!/usr/bin/env bash

# check if no arguments provided
if [ -z "$1" ]; then
    echo "Error: Empty parameter" >&2 # redirect to standard error output 
    exit 1
fi

# check if file exists
if [ ! -f "$1" ]; then
    echo "Error: File not found" >&2
    exit 1
fi

cat "$1"

```  

---

### Problem 2

#### Task

Write a shell script that takes arguments as a string of multiple words separated by spaces, and prints the words one per line.  

*For example:*  

| Test | Input | Result |
| --- | --- | --- |
| Test 1 | a ab abc | a |
| | | ab |
| | | abs |

#### Solution

```bash
#!/usr/bin/env bash
if [ -z "$1" ]; then
    echo "Error: Empty parameter" >&2
    exit 1
fi

for i in "$@"; do # for every argument of all
   printf "%s\n" "$i"
done

```

---

### Problem 3

#### Task

Please create a bash script to create 5 text files named "file" and file number containing numbers from 0 and extension txt , for example "file2.txt". Save data about file creation in the "log.log" file. Output the contents of the "log.log" file.  

*For example:*  

| Test | Result |
| --- | --- |
| Test | This is file 0. file0.txt |
| | This is file 1. file1.txt |
| | This is file 2. file2.txt |
| | This is file 3. file3.txt |
| | This is file 4. file4.txt |

#### Solution

```bash
#!/usr/bin/env bash

# create log file or clear it if existing
> log.log

for ((i=0; i<5; i++)) 
do
    filename="file${i}.txt"

    touch "$filename" # create file or update timestamp if exists
    
    echo "This is file ${i}. $filename" >> log.log # append to log file
done

cat ./log.log

```

---

## Advanced problem

#### Task

Write a script that takes a string as a parameter, checks if it represents a  <span style="color: red">URL</span> that uses the <span style="color: red">HTTPS</span> protocol, and returns the  <span style="color: red">URL</span>; if it does not, the script should return the message  <span style="color: red">Error</span>.  

#### Solution

```bash
#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "Usage: $0 URL" >&2
fi

string="$1"

if [[ "$string" =~ ^https://.+ ]]; then
    echo "$string"
else
    echo "Error"
fi

```  

#### <span style="color: green"> Better solution </span>

> It is a better solution, but it couldn't be handled properly by check algorithms on the Moodle site (because of `exit`)  

```bash
#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "Usage: $0 URL" >&2
    exit 1
fi

string="$1"

if [[ "$string" =~ ^https://.+ ]]; then
    echo "$string"
    exit 0
else
    echo "Error" >&2
    exit 1
fi

```

---

### Summary  

*What I learned while completing these tasks:*  

#### 1. File handeling in **bash**

- check if a file exist before processing: `-f` (flag)  
- use `touch` to create file  
- use `cat` to display content of file  

#### 2. Handeling command-line arguments

Access script arguments:  
`$0` (for the script name itself);  
`$1` (for the first arg);  
`$@` (for all args).  

#### 3. Regex

Use regex to validate *https* URLs: `^https://.+`  
> `^` for start of the line; `.+` for matching at least one symbol  
