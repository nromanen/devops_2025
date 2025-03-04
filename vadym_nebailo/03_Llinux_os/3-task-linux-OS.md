- Add a user with your name to the operating system.
- Assign the user to the root group to provide administrative privileges.

```bash
osboxes@osboxes:~$ sudo adduser vadym
[sudo] password for osboxes: 
info: Adding user `vadym' ...
info: Selecting UID/GID from range 1000 to 59999 ...
info: Adding new group `vadym' (1001) ...
info: Adding new user `vadym' (1001) with group `vadym (1001)' ...
info: Creating home directory `/home/vadym' ...
info: Copying files from `/etc/skel' ...
New password: 
Retype new password: 
passwd: password updated successfully
Changing the user information for vadym
Enter the new value, or press ENTER for the default
	Full Name []: Vadym Nedbailo
	Room Number []: 
	Work Phone []: 
	Home Phone []: 
	Other []: 
Is the information correct? [Y/n] 
info: Adding new user `vadym' to supplemental / extra groups `users' ...
info: Adding user `vadym' to group `users' ...
osboxes@osboxes:~$ sudo usermod -aG sudo vadym
osboxes@osboxes:~$ groups vadym
vadym : vadym sudo users
osboxes@osboxes:~$ 
```

- Re-login to the system with the new user account to ensure changes take effect.
```bash
rezus@laptop:~$ ssh vadym@127.0.0.1 -p 22222
vadym@127.0.0.1 password: 
Welcome to Ubuntu 24.04 LTS (GNU/Linux 6.8.0-35-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

To restore this content, you can run the 'unminimize' command.

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

vadym@osboxes:~$ 
```

- Create a folder named after your first name within your home directory.
- Inside this folder, create a file named after your last name.

```bash
vadym@osboxes:~$ pwd
/home/vadym
vadym@osboxes:~$ mkdir vadym
vadym@osboxes:~$ cd vadym/
vadym@osboxes:~/vadym$ pwd
/home/vadym/vadym
vadym@osboxes:~/vadym$ touch nedbailo.txt
vadym@osboxes:~/vadym$ ls
nedbailo.txt
vadym@osboxes:~/vadym$
```

[//]: screenshot
https://drive.google.com/file/d/1-smVYsTD4CWicPvwmjuGvfzD_rG0Y8EY/view?usp=sharing

- Create a symbolic link pointing to your last name file.
```bash
vadym@osboxes:~/vadym$ cd ..
vadym@osboxes:~$ pwd
/home/vadym
vadym@osboxes:~$ ln -s vadym/nedbailo.txt link_to_nedbailo.txt
vadym@osboxes:~$ ll
total 28
drwxr-x--- 4 vadym vadym 4096 Feb 18 12:51 ./
drwxr-xr-x 4 root  root  4096 Feb 18 12:36 ../
-rw-r--r-- 1 vadym vadym  220 Feb 18 12:36 .bash_logout
-rw-r--r-- 1 vadym vadym 3771 Feb 18 12:36 .bashrc
drwx------ 2 vadym vadym 4096 Feb 18 12:39 .cache/
-rw-r--r-- 1 vadym vadym  807 Feb 18 12:36 .profile
lrwxrwxrwx 1 vadym vadym   18 Feb 18 12:51 link_to_nedbailo.txt -> vadym/nedbailo.txt
drwxrwxr-x 2 vadym vadym 4096 Feb 18 12:44 vadym/
vadym@osboxes:~$ 
```

- Copy your last name file to the top-level directory (root) to demonstrate file access across directories.

``` bash
vadym@osboxes:~$ sudo cp vadym/nedbailo.txt /nedbailo.txt
[sudo] password for vadym: 
vadym@osboxes:~$ ll /
total 4194396
drwxr-xr-x  23 root root       4096 Feb 18 12:53 ./
drwxr-xr-x  23 root root       4096 Feb 18 12:53 ../
lrwxrwxrwx   1 root root          7 Apr 22  2024 bin -> usr/bin/
drwxr-xr-x   2 root root       4096 Feb 26  2024 bin.usr-is-merged/
drwxr-xr-x   4 root root       4096 Jun  4  2024 boot/
dr-xr-xr-x   2 root root       4096 Apr 23  2024 cdrom/
drwxr-xr-x  19 root root       4080 Feb 18 08:35 dev/
drwxr-xr-x  83 root root       4096 Feb 18 12:37 etc/
drwxr-xr-x   4 root root       4096 Feb 18 12:36 home/
lrwxrwxrwx   1 root root          7 Apr 22  2024 lib -> usr/lib/
drwxr-xr-x   2 root root       4096 Feb 26  2024 lib.usr-is-merged/
lrwxrwxrwx   1 root root          9 Apr 22  2024 lib64 -> usr/lib64/
drwx------   2 root root      16384 Jun  4  2024 lost+found/
drwxr-xr-x   2 root root       4096 Apr 23  2024 media/
drwxr-xr-x   2 root root       4096 Apr 23  2024 mnt/
-rw-r--r--   1 root root          0 Feb 18 12:53 nedbailo.txt
drwxr-xr-x   2 root root       4096 Apr 23  2024 opt/
dr-xr-xr-x 158 root root          0 Feb 18 08:35 proc/
drwx------   4 root root       4096 Jun  4  2024 root/
drwxr-xr-x  24 root root        740 Feb 18 12:39 run/
lrwxrwxrwx   1 root root          8 Apr 22  2024 sbin -> usr/sbin/
drwxr-xr-x   2 root root       4096 Apr  3  2024 sbin.usr-is-merged/
drwxr-xr-x   2 root root       4096 Jun  4  2024 snap/
drwxr-xr-x   2 root root       4096 Apr 23  2024 srv/
-rw-------   1 root root 4294967296 Jun  4  2024 swap.img
dr-xr-xr-x  13 root root          0 Feb 18 08:35 sys/
drwxrwxrwt  10 root root       4096 Feb 18 08:46 tmp/
drwxr-xr-x  12 root root       4096 Apr 23  2024 usr/
drwxr-xr-x  13 root root       4096 Jun  4  2024 var/
vadym@osboxes:~$ 

```

[//]: screenshot
https://drive.google.com/file/d/1vsnCUDIYuum0OFsXIyi0sDD_uPx9DcM9/view?usp=sharing

- Change the owner of the copied file to root and adjust its access rights to `644` to restrict permissions appropriately.
```bash
vadym@osboxes:~$ sudo chown root:root /nedbailo.txt
vadym@osboxes:~$ sudo chmod 644 /nedbailo.txt 
vadym@osboxes:~$ ll /nedbailo.txt 
-rw-r--r-- 1 root root 0 Feb 18 12:53 /nedbailo.txt
vadym@osboxes:~$ 
```

- Use the command line to create a new user group with the name `students` and add your user to this group.
```bash
vadym@osboxes:~$ sudo groupadd students
vadym@osboxes:~$ sudo usermod -aG students vadym
vadym@osboxes:~$ groups vadym
vadym : vadym sudo users students
vadym@osboxes:~$ 
```

- Create a compressed backup of your last name file using the `tar` command and store it in your home directory.
```
vadym@osboxes:~$ cd ~/vadym/
vadym@osboxes:~/vadym$ tar -czvf ~/nedbailo_backup.tar.gz nedbailo.txt
nedbailo.txt
vadym@osboxes:~/vadym$ ll ~
total 32
drwxr-x--- 4 vadym vadym 4096 Feb 18 13:06 ./
drwxr-xr-x 4 root  root  4096 Feb 18 12:36 ../
-rw-r--r-- 1 vadym vadym  220 Feb 18 12:36 .bash_logout
-rw-r--r-- 1 vadym vadym 3771 Feb 18 12:36 .bashrc
drwx------ 2 vadym vadym 4096 Feb 18 12:39 .cache/
-rw-r--r-- 1 vadym vadym  807 Feb 18 12:36 .profile
-rw-r--r-- 1 vadym vadym    0 Feb 18 12:53 .sudo_as_admin_successful
lrwxrwxrwx 1 vadym vadym   18 Feb 18 12:51 link_to_nedbailo.txt -> vadym/nedbailo.txt
-rw-rw-r-- 1 vadym vadym  122 Feb 18 13:10 nedbailo_backup.tar.gz
drwxrwxr-x 2 vadym vadym 4096 Feb 18 12:44 vadym/
vadym@osboxes:~/vadym$ 
```

[//]: screenshot
https://drive.google.com/file/d/1MB1R7cs7olpeHTse1nIwnjQ2pvDu4HqK/view?usp=sharing

- Use the `du` command to analyze the disk usage of your home directory, then display the top 5 largest files or directories.
```bash
vadym@osboxes:~$ du -sh ~
28K	/home/vadym
vadym@osboxes:~$ du -ah ~ | sort -rh | head -n 5
28K	/home/vadym
4.0K	/home/vadym/vadym
4.0K	/home/vadym/nedbailo_backup.tar.gz
4.0K	/home/vadym/.profile
4.0K	/home/vadym/.cache
vadym@osboxes:~$ 
```

- Utilize the find command to locate all files (including your last name file) within your home directory that have been modified within the last 7 days.
```
vadym@osboxes:~$ find ~ -type f -mtime -7
/home/vadym/.sudo_as_admin_successful
/home/vadym/nedbailo_backup.tar.gz
/home/vadym/.profile
/home/vadym/.bash_logout
/home/vadym/vadym/nedbailo.txt
/home/vadym/.bashrc
/home/vadym/.cache/motd.legal-displayed
vadym@osboxes:~$ 
```
[//]: screenshot
https://drive.google.com/file/d/1eBP4XtmYyzbXtvFfHaMu90mKVKp1_Irv/view?usp=sharing