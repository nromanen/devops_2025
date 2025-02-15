##Створила користувача. Перевірила, чи можна зайти під створеним користувачем. Створила директорію та файл в директорії.
## Перевірила права на директорію та файл.
\'''
iryna@ubuntu:~$ sudo su
[sudo] password for iryna:
root@ubuntu:/home/iryna# useradd -m -G root -s /bin/bash irena
root@ubuntu:/home/iryna# passwd irena
New password:
Retype new password:
passwd: password updated successfully
root@ubuntu:/home/iryna# sudo irena
sudo: irena: command not found
root@ubuntu:/home/iryna# exit
exit
iryna@ubuntu:~$ su irena
Password:
irena@ubuntu:/home/iryna$ cd ~
irena@ubuntu:~$ pwd
/home/irena
irena@ubuntu:~$ mkdir irena_task
irena@ubuntu:~$ touch /home/irena/irena_task/chernobel
irena@ubuntu:~$ cd irena_task/
irena@ubuntu:~/irena_task$ ls -l
total 0
-rw-r--r-- 1 irena irena 0 Feb 13 08:40 chernobel
irena@ubuntu:~/irena_task$
\'''
##Створила символічне посилання на директорію.
## Перевірила, чи воно створене. Перейшла в директорію, створила файл та перевірила, чи він створений.

irena@ubuntu:~$ ln -s /home/irena/irena_task/chernobel /home/irena/chernobel_link
irena@ubuntu:~$ ls -la

3 irena irena 4096 Feb 13 08:52
root root 4096 Feb 13 08:33
irena irena 220 Mar 31 2024 .bash_logout
irena irena 3771 Mar 31 2024 .bashrc
lrwxrwxrwx 1 irena irena 82 Feb 13 08:52 chernobel_link -> /home/irena/irena_task/chernobel
drwxr-xr-x 2 irena irena 4096 Feb 13 08:48 irena_task
-rw-r--r-- 1 irena irena 807 Mar 31 2024 .profile
irena@ubuntu:~$ cd irena_task/
irena@ubuntu:~/irena_task$ ls -la

irena irena 4096 Feb 13 08:48
irena irena 4096 Feb 13 08:52
irena@ubuntu:~/irena_task$ touch chernobel
irena@ubuntu:~/irena_task$ ls -la

irena irena 4096 Feb 13 08:54
irena irena 4096 Feb 13 08:54
-rw-rw-r-- 1 irena irena 0 Feb 13 08:54 chernobel
irena@ubuntu:~/irena_task$ cd ..
irena@ubuntu:~$ ls -la

irena irena 4096 Feb 13 08:52
root root 4096 Feb 13 08:33
irena irena 220 Mar 31 2024 .bash_logout
irena irena 3771 Mar 31 2024 .bashrc
lrwxrwxrwx 1 irena irena 82 Feb 13 08:52 chernobel_link -> /home/irena/irena_task/chernobel
drwxr-xr-x 2 irena irena 4096 Feb 13 08:54 irena_task
-rw-r--r-- 1 irena irena 807 Mar 31 2024 .profile

##Спробувала скопіювати файл в кореневу директорію. Помилка, оскільки немає прав на запис в кореневу директорію.

irena@ubuntu:~/irena_task$ ls -la
total 8
drwxr-xr-x 2 irena irena 4096 Feb 13 08:54 .
drwxr-xr-x 3 irena irena 4096 Feb 13 08:52 ..
-rw-r--r-- 1 irena irena 0 Feb 13 08:54 chernobel
irena@ubuntu:~/irena_task$ cd ..
irena@ubuntu:~$ ls -la
total 24
drwxr-x--- 3 irena irena 4096 Feb 13 08:52 .
drwxr-xr-x 5 root  root  4096 Feb 13 08:33 ..
-rw-r--r-- 1 irena irena 220 Mar 31 2024 .bash_logout
-rw-r--r-- 1 irena irena 3771 Mar 31 2024 .bashrc
lrwxrwxrwx 1 irena irena 82 Feb 13 08:52 chernobel_link -> /home/irena/irena_task/chernobel
drwxr-xr-x 2 irena irena 4096 Feb 13 08:54 irena_task
-rw-r--r-- 1 irena irena 807 Mar 31 2024 .profile
irena@ubuntu:~$ cp irena_task/chernobel /
cp: cannot create regular file '/chernobel': Permission denied

##Змінила власника та групу файлу та директорії. Перевірила зміни.
irena@ubuntu:/home/irena$ sudo su
[sudo] password for iryna:
root@ubuntu:/home/irena# chown root:root /home/irena/irena_task/chernobel
root@ubuntu:/home/irena# chmod 644 /home/irena/irena_task/chernobel
root@ubuntu:/home/irena# cd irena_task/
root@ubuntu:/home/irena/irena_task# ls -la
total 8
drwxr-xr-x 2 irena irena 4096 Feb 13 08:54 .
drwxr-x--- 3 irena irena 4096 Feb 13 08:52 ..
-rw-r--r-- 1 root root 0 Feb 13 08:54 chernobel
root@ubuntu:/home/irena/irena_task#

##Створила групу students. Додала користувача irena до групи students.
## Перевірила, чи користувач належить до групи students.
root@ubuntu:/home/irena/irena_task# sudo groupadd students
root@ubuntu:/home/irena/irena_task# usermod -aG students irena
root@ubuntu:/home/irena/irena_task# groups irena
irena : irena root students

##Створила архів з директорії chernobel. Перевірила, чи архів створений.
root@ubuntu:/home# tar -czvf /home/irena/irena_task/chernobel.tar.gz /home/irena/irena_task/chernobel
tar: Removing leading `/' from member names
home/irena/irena_task/chernobel

root@ubuntu:/home# ls -la
total 20
drwxr-xr-x  5 root  root  4096 Feb 13 08:33  ..
drwxr-xr-x 23 root  root  4096 Feb  6 08:58  .
drwxr-x--- 3 irena irena 4096 Feb 13 08:52  irena
drwxr-x--- 4 iryna iryna 4096 Feb  6 13:15  iryna

root@ubuntu:/home# cd irena/irena_task/
root@ubuntu:/home/irena/irena_task# ls -la
total 16
drwxr-xr-x 2 irena irena 4096 Feb 13 09:22  .
drwxr-x--- 3 irena irena 4096 Feb 13 08:52  ..
-rw-r--r-- 1 root  root  3403 Feb 13 09:17  chernobel
-rw-r--r-- 1 root  root  3943 Feb 13 09:23  chernobel.tar.gz

root@ubuntu:/home/irena/irena_task#

##Вивела інформацію про розмір файлів.
## Вивела 5 файлів з найбільшим розміром. відсортувала файли по змінах за останні 7 днів.

root@ubuntu:/home/irena# du
12	./irena_task
28	.

root@ubuntu:/home/irena# du -ah
4.0K	./.profile
4.0K	./irena_task/chernobel.tar.gz
4.0K	./irena_task/chernobel
12K	./irena_task
0	./chernobel_link
4.0K	./.bashrc
4.0K	./.bash_logout
28K	.

root@ubuntu:/home/irena# du -ah | sort -rh | head -5
28K	.
12K	./irena_task
4.0K	./.profile
4.0K	./irena_task/chernobel.tar.gz
4.0K	./irena_task/chernobel

root@ubuntu:/home/irena# find -type f -mtime -7
./irena_task/chernobel.tar.gz
./irena_task/chernobel

