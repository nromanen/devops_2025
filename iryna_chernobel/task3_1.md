## Створила групу  та користувачів.
```
root@ubuntu:/home/iryna# sudo groupadd developers2  
root@ubuntu:/home/iryna# sudo useradd -m -G developers2 -s /bin/bash dev2
root@ubuntu:/home/iryna# sudo useradd -m -G developers2 -s /bin/bash test2
root@ubuntu:/home/iryna# passwd dev2
New password:
Retype new password:
passwd: password updated successfully
root@ubuntu:/home/iryna# passwd test2
New password:
Retype new password:
passwd: password updated successfully
```
## Додала користувачам груп як другорядну.
```
root@ubuntu:/home/iryna# sudo usermod -aG developers2 dev2
root@ubuntu:/home/iryna# sudo usermod -aG developers2 test2
```
## Створила спільну папку та надала доступи.
```
root@ubuntu:/home/iryna# sudo mkdir /home/shared_folder
root@ubuntu:/home/iryna# sudo chown :developers2 /home/shared_folder  
root@ubuntu:/home/iryna# sudo chmod 2775 /home/shared_folder  
```

## Створила додаткову спільну папку. Додала наведені права. Перевірила права у двох папках.
```
root@ubuntu:/home/iryna# sudo mkdir /home/public_folder
root@ubuntu:/home/iryna# sudo chmod g+t /home/public_folder/
root@ubuntu:/home/iryna# ls -ld /home/shared_folder/
drwxrwsr-x 2 root developers2 4096 Feb 15 10:43 /home/shared_folder/
root@ubuntu:/home/iryna# ls -ld /home/public_folder
drwxr-xr-x 2 root root 4096 Feb 15 10:53 /home/public_folder
root@ubuntu:/home/iryna#
```

```

##Посилання на скріншоти: https://drive.google.com/drive/folders/16tNWzylZOFDx_mMfYGpNazFsPbQQAXoH?usp=sharing
```