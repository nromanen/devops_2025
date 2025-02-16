
## 1. Creating a New User
Add a user with your name to the operating system:

```bash
polina@ubuntu:~$ sudo useradd -m -s /bin/bash polinadyka
[sudo] password for polina: 
```

## 2. Assigning Administrative Privileges
Assign the user to the root group to provide administrative privileges:

```bash
polina@ubuntu:~$ sudo usermod -aG root polinadyka
polina@ubuntu:~$ groups polinadyka
polinadyka : polinadyka root
```

## 3. Re-logging with the New User Account
Re-login to the system with the new user account to ensure changes take effect:

```bash
polina@ubuntu:~$ su - polinadyka
Password: 
polinadyka@ubuntu:~$ whoami
polinadyka
```

## 4. Creating a Directory and File
Create a folder named after your first name within your home directory:

```bash
polinadyka@ubuntu:~$ mkdir ~/polina
```

Inside this folder, create a file named after your last name:

```bash
polinadyka@ubuntu:~$ touch ~/polina/dyka
```

Verify the file creation:

```bash
polinadyka@ubuntu:~$ ls -l ~/polina
total 0
-rw-rw-r-- 1 polinadyka polinadyka 0 Feb 15 11:07 dyka
```

## 5. Creating a Symbolic Link
Create a symbolic link pointing to your last name file:

```bash
polinadyka@ubuntu:~$ ln -s ~/polina/dyka ~/link_to_dyka
```

Verify the symbolic link:

```bash
polinadyka@ubuntu:~$ ls -l ~/
total 4
lrwxrwxrwx 1 polinadyka polinadyka   28 Feb 15 11:09 link_to_dyka -> /home/polinadyka/polina/dyka
drwxrwxr-x 2 polinadyka polinadyka 4096 Feb 15 11:07 polina
```

## 6. Copying the File to the Root Directory
Copy your last name file to the top-level directory (root) to demonstrate file access across directories:

```bash
polinadyka@ubuntu:~$ sudo cp ~/polina/dyka /dyka
[sudo] password for polinadyka: 
```

Verify the copied file:

```bash
polinadyka@ubuntu:~$ ls -l /
total 80
lrwxrwxrwx   1 root root     7 Apr 22  2024 bin -> usr/bin
drwxr-xr-x   2 root root  4096 Feb 26  2024 bin.usr-is-merged
drwxr-xr-x   5 root root  4096 Feb  7 19:50 boot
dr-xr-xr-x   2 root root  4096 Aug 27 15:43 cdrom
drwxr-xr-x  20 root root  4040 Feb 15 10:58 dev
-rw-r--r--   1 root root     0 Feb 15 11:16 dyka
drwxr-xr-x 106 root root  4096 Feb 15 11:15 etc
drwxr-xr-x   4 root root  4096 Feb 15 11:02 home
lrwxrwxrwx   1 root root     7 Apr 22  2024 lib -> usr/lib
drwxr-xr-x   2 root root  4096 Feb 26  2024 lib.usr-is-merged
drwx------   2 root root 16384 Feb  7 19:47 lost+found
drwxr-xr-x   2 root root  4096 Aug 27 14:19 media
drwxr-xr-x   2 root root  4096 Aug 27 14:19 mnt
drwxr-xr-x   2 root root  4096 Aug 27 14:19 opt
dr-xr-xr-x 190 root root     0 Feb 15 10:58 proc
drwx------   3 root root  4096 Aug 27 14:25 root
drwxr-xr-x  27 root root   820 Feb 15 11:01 run
lrwxrwxrwx   1 root root     8 Apr 22  2024 sbin -> usr/sbin
drwxr-xr-x   2 root root  4096 Mar 31  2024 sbin.usr-is-merged
drwxr-xr-x   2 root root  4096 Feb  7 19:56 snap
drwxr-xr-x   2 root root  4096 Aug 27 14:19 srv
dr-xr-xr-x  13 root root     0 Feb 15 10:58 sys
drwxrwxrwt  12 root root  4096 Feb 15 10:58 tmp
drwxr-xr-x  11 root root  4096 Aug 27 14:19 usr
drwxr-xr-x  13 root root  4096 Feb  7 19:56 var
```

## 7. Changing File Ownership and Permissions
Change the owner of the copied file to root and adjust its access rights to 644:

```bash
polinadyka@ubuntu:~$ sudo chown root:root /dyka
polinadyka@ubuntu:~$ sudo chmod 644 /dyka
```

Verify the changes:

```bash
polinadyka@ubuntu:~$ ls -l /dyka
-rw-r--r-- 1 root root 0 Feb 15 11:16 /dyka
```

## 8. Creating a New User Group and Assigning the User
Use the command line to create a new user group with the name `students` and add your user to this group:

```bash
polinadyka@ubuntu:~$ sudo groupadd students
polinadyka@ubuntu:~$ sudo usermod -aG students polinadyka
```

Verify group membership:

```bash
polinadyka@ubuntu:~$ groups polinadyka
polinadyka : polinadyka root sudo students
```

## 9. Creating a Compressed Backup
Create a compressed backup of your last name file using the tar command and store it in your home directory:

```bash
polinadyka@ubuntu:~$ tar -cvzf ~/backup_dyka.tar.gz /dyka
tar: Removing leading `/' from member names
/dyka
```

Verify the backup file:

```bash
polinadyka@ubuntu:~$ ls -l ~/
total 8
-rw-rw-r-- 1 polinadyka polinadyka  109 Feb 15 11:18 backup_dyka.tar.gz
lrwxrwxrwx 1 polinadyka polinadyka   28 Feb 15 11:09 link_to_dyka -> /home/polinadyka/polina/dyka
drwxrwxr-x 2 polinadyka polinadyka 4096 Feb 15 11:07 polina
```

## 10. Analyzing Disk Usage
Use the du command to analyze the disk usage of your home directory, then display the top 5 largest files or directories.

```bash
polinadyka@ubuntu:~$ du -sh ~/
24K	/home/polinadyka/
polinadyka@ubuntu:~$ du -ah ~/ | sort -rh | head -n 5
24K	/home/polinadyka/
4.0K	/home/polinadyka/.profile
4.0K	/home/polinadyka/polina
4.0K	/home/polinadyka/.bashrc
4.0K	/home/polinadyka/.bash_logout
```

## 11. Finding Recently Modified Files
Utilize the `find` command to locate all files (including your last name file) within your home directory that have been modified within the last 7 days:

```bash
polinadyka@ubuntu:~$ find ~/ -type f -mtime -7
/home/polinadyka/backup_dyka.tar.gz
/home/polinadyka/polina/dyka
/home/polinadyka/.sudo_as_admin_successful
```