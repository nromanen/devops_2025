### [Task] KillerCoda Linux OS

[https://drive.google.com/file/d/1N9i6Kr_nxCt79x08_0URr5aOwuMvG_K9/view?usp=sharing](https://drive.google.com/file/d/1N9i6Kr_nxCt79x08_0URr5aOwuMvG_K9/view?usp=sharing)


### [Tasks] Linux OS

- Add a user with your name to the operating system.
- Assign the user to the root group to provide administrative privileges.
- Re-login to the system with the new user account to ensure changes take effect.

```
vboxuser@ubuntu:~$ sudo useradd -m yaryna
[sudo] password for vboxuser:

vboxuser@ubuntu:~$ sudo usermod -aG sudo yaryna

vboxuser@ubuntu:~$ groups yaryna
yaryna : yaryna sudo

vboxuser@ubuntu:~$ sudo passwd yaryna
New password:
Retype new password:
passwd: password updated successfully

vboxuser@ubuntu:~$ su - yaryna
Password:

$ whoami
yaryna

$ sudo whoami
[sudo] password for yaryna:
root
```

- Create a folder named after your first name within your home directory.
- Inside this folder, create a file named after your last name.
- Create a symbolic link pointing to your last name file.

```
$ cd ~
$ mkdir ./yaryna
$ touch ./yaryna/hushuley
$ ln -s ./yaryna/hushuley ./yaryna/hushuley.lnk

$ ls -lR ~
/home/yaryna:
total 4
drwxrwxr-x 2 yaryna yaryna 4096 Feb 18 12:32 yaryna

/home/yaryna/yaryna:
total 0
-rw-rw-r-- 1 yaryna yaryna  0 Feb 18 12:32 hushuley
lrwxrwxrwx 1 yaryna yaryna 17 Feb 18 12:32 hushuley.lnk -> ./yaryna/hushuley
```

- Copy your last name file to the top-level directory (root) to demonstrate file access across directories.
- Change the owner of the copied file to root and adjust its access rights to 644 to restrict permissions appropriately.

```
$ sudo cp ~/yaryna/hushuley /hushuley
$ sudo chmod 644 /hushuley
$ sudo chown root:root /hushuley

$ ls -l / | grep hushuley
-rw-r--r--   1 root root     0 Feb 18 12:34 hushuley
```

- Use the command line to create a new user group with the name students and add your user to this group.
- Create a compressed backup of your last name file using the tar command and store it in your home directory.

```
$ sudo groupadd students
$ sudo usermod -aG students yaryna
$ groups yaryna
yaryna : yaryna sudo students

$ tar -czvf ~/hushuley.tar.gz yaryna/hushuley
$ ls -l ~
total 8
-rw-rw-r-- 1 yaryna yaryna  125 Feb 18 12:46 hushuley.tar.gz
drwxrwxr-x 2 yaryna yaryna 4096 Feb 18 12:32 yaryna
```

- Use the du command to analyze the disk usage of your home directory, then display the top 5 largest files or directories.
- Utilize the find command to locate all files (including your last name file) within your home directory that have been modified within the last 7 days.

```
$ du -ah ~ | sort -rh | head -n 5
44K     /home/yaryna
12K     /home/yaryna/.local
8.0K    /home/yaryna/.local/share
4.0K    /home/yaryna/yaryna
4.0K    /home/yaryna/.profile

$ find ~ -type f -mtime -7
/home/yaryna/hushuley.tar.gz
/home/yaryna/yaryna/hushuley
/home/yaryna/.sudo_as_admin_successful
/home/yaryna/.lesshst
/home/yaryna/.cache/motd.legal-displayed
```