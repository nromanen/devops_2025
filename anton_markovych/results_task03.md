# 03 Linux Task

## **1. Creating user and groups**

### Input
```bash
sudo adduser anton
sudo usermod -aG root anton
groups anton
```
### Output 
```
anton : anton root
```
## **2. Re-enter under a new user**

```bash
su - anton
```

## **3. Creating a folder, file, and symbolic link**

### Input
```bash
mkdir ~/anton
touch ~/anton/markovych
ln -s ~/anton/markovych ~/anton/markovych_link
```
### Output 
```bash
ls -al 
drwxrwxr-x 2 anton anton 4096 лют 15 14:55 anton

ls -al anton/
-rw-rw-r-- 1 anton anton 0 лют 15 14:53 markovych
lrwxrwxrwx 1 anton anton 27 лют 15 14:55 markovych -> /home/anton/anton/markovych
```
## **4. Copying a file and changing permissions**
### Input
```bash
sudo cp ~/anton/markovych /markovych_copy
sudo chown root:root /markovych_copy
sudo chmod 644 /markovych_copy
ls -l /
```
### Output
```
-rw-r--r-- 1 root root 0 лют 15 15:36 markovych_copy

```
## **5. Creating groups and adding a user to them**
### Input
```bash
sudo groupadd students
sudo usermod -aG students anton
groups anton
``` 
### Output
```
anton: anton root sudo users students
```
### **6. Creating a compressed backup of last name file using the tar command and store it in home directory.**
### Input
```bash
tar -cvf ~/markovych_backup.tar ~/anton/markovych
ls -al
```
### Output
```
-rw-r--r-- 1 anton anton 10240 лют 15 15:44 markovych_backup.tar
```
## **7.Use the ```du``` command to analyze the disk usage of home directory, then display the top 5 largest files or directories.**
### Input
```bash
du -ah ~ | sort -rh | head -5
```
### Output
```
36K     /home/anton
12K     /home/anton/markovych_backup.tar
4.0K    /home/anton/.profile
4.0K    /home/anton/.bashrc
4.0K    /home/anton/.bash_logout
```
## **8.Use the ```find``` command to locate all files within home directory that have been modified within the last 7 days.**
### Input
```bash
find ~ -type f -mtime -7
```
### Output
```
/home/anton/.bash_history
/home/anton/markovych_backup.tar
/home/anton/anton/markovych
/home/anton/.sudo_as_admin_soccessful
/home/anton/.bash_logout
/home/anton/.bashrc
/home/anton/.profile
```
