# Task 06: Text processing Tools

> Done by [@Lians-coder](https://github.com/Lians-coder) (Kateryna Kravchuk)

## Preparation 1  

The detailed process of gaining access to the Linux VM was described in [this section](https://github.com/nromanen/devops_2025/blob/kateryna_kravchuk/kateryna_kravchuk/task_03/task_03.md#0-preparation) of the same name in **Task 03**.  

---

## Basic Task 1  

### Task  

<span style="color: darkgreen">Download archive 'textprocessingtask.tar', there are needed files there.  
Using regular expressions and any of the tools like grep, sed, or awk, search for emails in the file 'user_data.txt' that start with 'sudo' and end with 'org'.</span>  

### Preparation 2  

1. Making a folder on the host machine to share it with the VM later (path in my case: *"F:/devopsv/oracle9/shared"*).  
Downloading the archive (I needed *.zip* for Windows host) from this [source](https://softserve.academy/pluginfile.php/434222/mod_assign/introattachment/0/textprocessingtask.zip?forcedownload=1).  
Unzipping it to the new *task_06* folder into the shared one and deleting the archive.  

2. Configuring *Vagrantfile* to set up a shared folder (by adding this line to **Vagrant.configure**):  

```ruby
     config.vm.synced_folder "F:/devopsv/oracle9/shared", "/home/kate_kr/shared"
```

3. Verifying the shared folder in VM  

Reloading VM by `vagrant reload`, connecting to it by `vagrant ssh` and switching to *kate_kr*.  
Going to the desired directory on the VM (*/home/kate_kr/shared/task_06*) and checking by `ls`:  

```sh
[vagrant@localhost ~]$ su - kate_kr
Password:
[kate_kr@localhost ~]$ cd /home/kate_kr/shared/task_06
[kate_kr@localhost task_06]$ ls
user_data_task2.txt  user_data.txt
[kate_kr@localhost task_06]$ 
```

### Solution  

```bash
grep -oE '(sudo\S*@[[:alnum:].]+\.org)' user_data.txt > sudo_org.txt
cat sudo_org.txt
```

Output:  

```sh
sudo_david+-millersell@ya2hoo.org
sudonoah_+scott@yahoo.org
```

### Notes  

I used these symbols in my **regex** pattern:  

| Symbol / class | Meaning |
| --- | --- |
| `.` | Any character |
| `\S` | Any non-whitespace character |
| `[[:alnum:]]` | Same as `[a-zA-Z0-9]` |
| `+` | Any quantity of previous symbol, but at least once |
| `\` | Match the next character literally |

**I used these commands:**  
`grep` to filter out data,  
`-o` flag for return only matched sections (and not entire lines),  
`-E` flag to use exended version of regex *(ERE)*,  
`>` to output results in a new *.txt* file,  
`cat` to display it.  

> This pattern **doesn't** properly validate emails, as now it allows *any characters* (including invalid ones) before `@`, and it allows alphanumeric characters and dots (*not ensuring proper domain levels*) after `@`, but actual email structure are more restrictive and complex.  

---

## Advanced Task  1  

### Task  

<span style="color: darkgreen">In the file 'user_data_task2.txt', identify all individuals who have a valid email address ending with 'com' and a weak password that lacks special characters such as **! № % : ?**</span>  

### Solution  

```bash
grep -oP '([\w.-]+@\w+\.com),\s([[:alnum:]]+)$' user_data_task2.txt > week_passwords.txt
cat week_passwords.txt
```

Output:  

```sh
sudobobbsinnn@gmail.com, 12345
sarahwills@gmail.com, 98765
emilydavis@gmail.com, 87654
```

### Notes  

I used this set of symbols in the **regex** (aside previously described):  

| Symbol / class | Meaning |
| --- | --- |
| `\s` | Any whitespace (`[[:space:]]`) |
| `\w` | Same as `[a-zA-Z0-9_]` with *boundary* check at the end |
| `$` | End of the line |

I also used `-P` flag with `grep` for Perl-compatible regex *(PCRE)* for more control over pattern (e.g., for use `\w`).  
I prefer `\w` over `[[:alpha:]]`because it implicitly matches word boundaries (it also includes `_`).  

---

## Advanced Task 2  

### Task  

<span style="color: darkgreen">Based on the previous task's results, retrieve the name and password, and construct a sentence in the following format:

*{"sudobobbsinnn@gmail.com" : "Bob's password is 12345, it should be improved!"}*</span>  

### Solution  

I only needed to slightly modify the previous pattern by adding a new capturing group and then appending commands to process the findings.  

```bash
grep -oP '([[:alpha:]]+),\s[[:alpha:]]+,\s([\w.-]+@\w+\.com),\s([[:alnum:]]+)$' user_data_task2.txt | awk -F", " '{print "{\""$3"\" : \""$1"'\''s password is "$4", it should be improved!\"}"}' > names_week.json
cat names_week.json
```

Output:  

```json
{"sudobobbsinnn@gmail.com" : "Bob's password is 12345, it should be improved!"}
{"sarahwills@gmail.com" : "Sarah's password is 98765, it should be improved!"}
{"emilydavis@gmail.com" : "Emily's password is 87654, it should be improved!"}
```

#### An alternative (simpler) solution  

Make a file with all columns from *user_data.txt* (as in [advanced task 1](https://github.com/nromanen/devops_2025/blob/kateryna_kravchuk/kateryna_kravchuk/task_06/task_06.md#advanced-task-2), but without filtering out other non-relevant information).  

```bash
grep -oP '.*,\s[[:alpha:]]+,\s([\w.-]+@\w+\.com),\s([[:alnum:]]+)$' user_data_task2.txt > week_passwords_simple.txt
cat week_passwords_simple.txt
```

Output:  

```bash
1, Bob, Sinkler, sudobobbsinnn@gmail.com, 12345
4, Sarah, Williams, sarahwills@gmail.com, 98765
6, Emily, Davis, emilydavis@gmail.com, 87654
```

Then, run this file as input for `awk`, noting that the column references have changed due to the updated file structure:  

```bash
cat week_passwords_simple.txt | awk -F", " '{print "{\""$4"\" : \""$2"'\''s password is "$5", it should be improved!\"}"}' > names_week_simple.json
cat names_week_simple.json
```

Output is the same as in previous (one-liner version)!  

### Notes  

`awk` can split provided lines by default (using spaces). With the `-F", "` flag, we can configure it to split on comma-space (`", "`) pairs. If we do so, each separated part can be referenced in order of occurrence.  

---

## General notes

Here are some *regex* that I used during the process of finding the matches I wanted.  
Somehow, it's not processing the same on Linux OS compared with what I checked on [this site](https://regex101.com/) (and that's why patterns I actually used are slightly different from what I've had tested).  

| Symbol / class | Meaning |
| --- | --- |
| `^` | Start of the line |
| `*` | Any quantity of previous character / group |
| `\d` | `[[:digit:]]`(same as `[0-9]`) |
| `[[:alpha:]]` | Same as `[a-zA-Z]` |

> I had particularly hard time trying to make `'` in `awk '{print "{<something>}"}'` statement work correctly: i needed the `'\''` pattern inside the string I was trying to print for concatenate its two parts (first and last `'`) and for escape one (`\'` part).  

---

## Screenshots

### Preparation  

[Reloading](https://drive.google.com/file/d/1urWRyc8USV8aXVXaEguiQnbYuHD1G8MP/view?usp=drive_link) VM after configuring *Vagrantfile* and [checking](https://drive.google.com/file/d/1CwHKUJUpxU8tryxrZK0PpxwBKLYrHuTx/view?usp=drive_link) the proper functioning of the shared directory.  

### Regex patterns

[Matches](https://drive.google.com/file/d/1t5GsVpxrnxO9DS76vO1O5Ii4lN4uZSd8/view?usp=drive_link) for `^.*(sudo\S*@[[:alnum:].-]+\.org).*$` (basic task).  
[Matches](https://drive.google.com/file/d/1k7X_v5GlVi4DiL4ukYEPKSlF0Lty0wgz/view?usp=drive_link) for `^\d+,\s([[:alpha:]]+),\s[[:alpha:]]+,\s([\w.-]+@\w+\.com),\s([[:alnum:]]+)$` (advanced tasks).  
*Step-by-step* filtering: matches for [names](https://drive.google.com/file/d/187iLql81nO_m7ep5BoqqO2A0pnr0RIyb/view?usp=drive_link), [emails](https://drive.google.com/file/d/1H2Fzz9zqmK-unW5A6PaezdxDMbXW4pGC/view?usp=drive_link) and [passwords](https://drive.google.com/file/d/1-QTKsLf5YcBonRBIRveKXNQxSyjTANhM/view?usp=drive_link) separately in *user_data_task2.txt*.  

### Commands & its outputs

Commands executed on *Oracle Linux 9 VM* for [basic](https://drive.google.com/file/d/1aAn96zMOWxCrXeFf5KjLcMJajRtF6MmY/view?usp=drive_link), [advanced 1](https://drive.google.com/file/d/1E11YNy8Er-rU49XuKfEP31InKms-dgPl/view?usp=drive_link), [advanced 2](https://drive.google.com/file/d/1VEvTnvfJbkG48vwwUnAzf9MQw9_hHbiB/view?usp=drive_link) tasks and [simpler](https://drive.google.com/file/d/1tDXiaIkisKdLCwsnDWqm8nb_bOo7W9nx/view?usp=drive_link) version of the latest one.  
