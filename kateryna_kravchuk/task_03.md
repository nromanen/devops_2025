# Task_03:  Linux OS

> Done by [@Lians-coder](https://github.com/Lians-coder) (Kateryna Kravchuk)


#### 0. Preparation

I will use the previously created virtual machine with Linux - Oracle Linux 9 via Vagrant:
`vagrant status`  

```bash
Current machine states:
default                   poweroff (virtualbox)
The VM is powered off. To restart the VM, simply run `vagrant up`
```

To power it on:  
`vagrant up`  

```bash
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Checking if box 'oraclelinux/9' version '9.5.649' is up to date...
==> default: Clearing any previously set forwarded ports...
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
    default: Adapter 2: hostonly
==> default: Forwarding ports...
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2222
    default: SSH username: vagrant
    default: SSH auth method: private key
    default: 
    default: Vagrant insecure key detected. Vagrant will automatically replace
    default: this with a newly generated keypair for better security.
    default: 
    default: Inserting generated public key within guest...
    default: Removing insecure key from the guest if it's present...
    default: Key inserted! Disconnecting and reconnecting using new SSH key...
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
==> default: Configuring and enabling network interfaces...
==> default: Mounting shared folders...
    default: E:/devopsv/oracle9 => /vagrant
```

To access it:  
`vagrant ssh`  

```bash
Welcome to Oracle Linux Server release 9.5 (GNU/Linux 5.15.0-206.153.7.el8uek.x86_64)
The Oracle Linux End-User License Agreement can be viewed here:
  * /usr/share/eula/eula.en_US
For additional packages, updates, documentation and community help, see:
  * https://yum.oracle.com/
```

---

#### 1. Add a user with your name to the operating system

`sudo useradd -m kate_kr`  
`sudo passwd kate_kr`  

```bash
Changing password for user kate_kr.
New password: 
Retype new password:
passwd: all authentication tokens updated successfully.
```

---

#### 2. Assign the user to the root group to provide administrative privileges

`sudo usermod -aG wheel kate_kr`  

Note: *wheel* is root group in hat-like linux distros.

---

#### 3. Re-login to the system with the new user account to ensure changes take effect

`su - kate_kr`  

Checking if the user is in the root group: `groups kate_kr`  

```bash
kate_kr: kate_kr wheel
```  

---

#### 4. Create a folder named after your first name within your home directory

`mkdir kate`  
`cd kate`  
`pwd`  

```bash
/home/kate_kr/kate
```

---

#### 5. Inside this folder, create a file named after your last name

`touch kr.txt`  
Checking out: `ls -l`  

```bash
-rw-r--r--. 1 kate_kr kate_kr   0 Feb 14 20:17 kr.txt/
```

---

#### 6. Create a symbolic link pointing to your last name file

`ln -s kr.txt kr.lnk`  

Checking out:  
`ls -l`  

```bash
lrwxrwxrwx. 1 kate_kr kate_kr 6 Feb 14 20:17 kr.lnk -> kr.txt
-rw-r--r--. 1 kate_kr kate_kr 0 Feb 14 20:17 kr.txt
```  

---

#### 7. Copy your last name file to the top-level directory (root) to demonstrate file access across directories

`sudo cp kr.txt /`  

```bash
[sudo] password for kate_kr: 
```  

Note: I should confirm any action I want to do in the root directory by providing a root password.  

---

#### 8. Change the owner of the copied file to root and adjust its access rights to 644 to restrict permissions appropriately

##### 8.1 Changing ownership  

`sudo chown root:root kr.txt`  

```bash
[sudo] password for kate_kr: 
```

> We should run this in root mode, and here what happens if we haven't:  

```bash
chown: changing ownership of 'kr.txt': Operation not permitted
```

###### 8.2 Changing mode  

`sudo chmod 644 kr.txt`  

```bash
[sudo] password for kate_kr: 
```

> Again, confirm our *root* privileges to do this, otherwise we get the following:  

```bash
chmod: changing permissions of 'kr.txt': Operation not permitted
```

##### 8.3 Checking out  

`ls -l kr.txt`  

```bash
-rw-r--r--. 1 root root 0 Feb 14 20:18 kr.txt
```  

Nothing changes in permissions, because the file already was in the desired state:  

| | owner | group | others |
| --- | --- | --- | --- |
| read | 4 | 4 | 4 |
| write | 2 | 0 | 0 |
|execute | 0 | 0 | 0 |
| | **6** | **4** | **4** |  

---

#### 9. Use the command line to create a new user group with the name students and add your user to this group

`sudo groupadd students`  
`sudo usermod -aG students kate_kr`  

Checking out: `groups kate_kr`  

```bash
kate_kr : kate_kr wheel students
```  

---

#### 10. Create a compressed backup of your last name file using the tar command and store it in your home directory

Run from *kate* directory: `tar -czf ~/kr.tar.gz kr.txt`  
Change to *home* directory: `cd ..`  
Ensure the archive creation: `ls -l`  

```bash
total 4
drwxr-xr-x. 2 kate_kr kate_kr  34 Feb 14 20:17 kate
-rw-r--r--. 1 kate_kr kate_kr 115 Feb 14 20:23 kr.tar.gz
```  

---

#### 11. Use the du command to analyze the disk usage of your home directory, then display the top 5 largest files or directories

Show disk usage (*-a* for all files, *-h* for human-readable sizes) of home directore (*~*): `du -ah ~`  

```bash
4.0K    /home/kate_kr/.bash_logout
4.0K    /home/kate_kr/.bash_profile
4.0K    /home/kate_kr/.bashrc
0       /home/kate_kr/kate/kr.txt
0       /home/kate_kr/kate/kr.lnk
0       /home/kate_kr/kate
8.0K    /home/kate_kr/.bash_history
4.0K    /home/kate_kr/kr.tar.gz
24K     /home/kate_kr
```  

Sort (*-r* for descending, *-h* for human-readable sizes) and show top 5 largest files: `du -ah ~ | sort -rh | head -5`  

```bash
24K     /home/kate_kr
8.0K    /home/kate_kr/.bash_history
4.0K    /home/kate_kr/kr.tar.gz
4.0K    /home/kate_kr/.bashrc
4.0K    /home/kate_kr/.bash_profile
```  

---

#### 12. Utilize the find command to locate all files (including your last name file) within your home directory that have been modified within the last 7 days  

`find ~ -type f -mtime -7`  

```bash
/home/kate_kr/kate/kr.txt
/home/kate_kr/.bash_history
/home/kate_kr/kr.tar.gz
```

---

### **Summary**

*What I learned while completing these tasks:*

#### 1. User & group management

- create a new user: `useradd -m <username> && passwd <username>`  
- assign administrative privileges: `usermod -aG sudo <username>`  
- create & manage groups: `groupadd <groupname>` & `usermod -aG <groupname> <username>`  
- apply changes by re-login: `su - <username>`  

#### 2. File & directory Management

- ceate directories and files: `mkdir ~/<foldername> && touch <filename>`  
- create symbolic links: `ln -s <targetfile> <linkname>`  
- list directory contents: `ls -l`  

#### 3. File permissions & ownership

- change file ownership: `chown root:root <filename>`  
- modify file permissions: `chmod XXX <filename>` (where *XXX* stands for numeric permission for user, group & others respectively)  

#### 4. System & disk management

- analyze disk usage: `du -ah ~`  
- applying filters to search: `sort -rh` and `head -5`  
- find files modified recently: `find ~/ -type f -mtime -7`  

#### 5. Compression

- compress a file: `tar -czf <filename>.tar.gz <filename>`  
