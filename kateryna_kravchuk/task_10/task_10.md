# Task 10: RDBMS

> Done by [@Lians-coder](https://github.com/Lians-coder) (Kateryna Kravchuk)

## 0. Preparation

### Task 0

Use the previously created virtual machine with Linux, ensure that it is powered on and accessible.  

### Solution 0

I will use **Ubuntu Linux Server 24 LTC** that was previously installed in the *Virtual Box*. The process of gaining acces described in [this](https://github.com/nromanen/devops_2025/blob/main/kateryna_kravchuk/task_09/task_09.md#preparation) part of Task 9.  

---

## 1. DB installation

### Task 1

Install <span style="color: #db1a74">MariaDB</span> on Ubuntu Linux.  

### Install

> Run `sudo apt update && upgrade` before if needed  

`sudo apt install mariadb-server -y`  

### Start service

To check the status: `sudo systemctl status mariadb`  

```bash
● mariadb.service - MariaDB 10.11.8 database server
     Loaded: loaded (/usr/lib/systemd/system/mariadb.service; enabled; preset: enabled)
     Active: active (running) since Wed 2025-03-12 07:47:06 UTC; 10min ago
       Docs: man:mariadbd(8)
             https://mariadb.com/kb/en/library/systemd/
   Main PID: 15954 (mariadbd)
     Status: "Taking your SQL requests now..."
      Tasks: 9 (limit: 15026)
     Memory: 78.6M (peak: 81.6M)
        CPU: 1.430s
     CGroup: /system.slice/mariadb.service
             └─15954 /usr/sbin/mariadbd

Mar 12 07:47:05 userver mariadbd[15954]: 2025-03-12  7:47:05 0 [Note] Plugin 'FEEDBACK' is disabled.
Mar 12 07:47:05 userver mariadbd[15954]: 2025-03-12  7:47:05 0 [Note] InnoDB: Loading buffer pool(s) from /var/lib/mysql/ib_buffer_pool
Mar 12 07:47:05 userver mariadbd[15954]: 2025-03-12  7:47:05 0 [Warning] You need to use --log-bin to make --expire-logs-days or --binlog-expire-logs-seconds work.
Mar 12 07:47:05 userver mariadbd[15954]: 2025-03-12  7:47:05 0 [Note] Server socket created on IP: '127.0.0.1'.
Mar 12 07:47:05 userver mariadbd[15954]: 2025-03-12  7:47:05 0 [Note] InnoDB: Buffer pool(s) load completed at 250312  7:47:05
Mar 12 07:47:05 userver mariadbd[15954]: 2025-03-12  7:47:05 0 [Note] /usr/sbin/mariadbd: ready for connections.
Mar 12 07:47:05 userver mariadbd[15954]: Version: '10.11.8-MariaDB-0ubuntu0.24.04.1'  socket: '/run/mysqld/mysqld.sock'  port: 3306  Ubuntu 24.04
Mar 12 07:47:06 userver systemd[1]: Started mariadb.service - MariaDB 10.11.8 database server.
Mar 12 07:47:06 userver /etc/mysql/debian-start[15971]: Upgrading MariaDB tables if necessary.
Mar 12 07:47:06 userver /etc/mysql/debian-start[15982]: Checking for insecure root accounts.
```

The third line from the end tells the *mariadb.service* has been successfully started.  
In case it's not: `sudo systemctl start mariadb.service`.  

### Configuration

`sudo mariadb-secure-installation`  

**Output** and *Y/n* choices to make during the secure installation:  

```bash
NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MariaDB
      SERVERS IN PRODUCTION USE!  PLEASE READ EACH STEP CAREFULLY!

In order to log into MariaDB to secure it, we'll need the current
password for the root user. If you've just installed MariaDB, and
haven't set the root password yet, you should just press enter here.

Enter current password for root (enter for none):
OK, successfully used password, moving on...

Setting the root password or using the unix_socket ensures that nobody
can log into the MariaDB root user without the proper authorisation.

You already have your root account protected, so you can safely answer 'n'.

Switch to unix_socket authentication [Y/n] n
 ... skipping.

You already have your root account protected, so you can safely answer 'n'.

Change the root password? [Y/n] n
 ... skipping.

By default, a MariaDB installation has an anonymous user, allowing anyone
to log into MariaDB without having to have a user account created for
them.  This is intended only for testing, and to make the installation
go a bit smoother.  You should remove them before moving into a
production environment.

Remove anonymous users? [Y/n] Y
 ... Success!

Normally, root should only be allowed to connect from 'localhost'.  This
ensures that someone cannot guess at the root password from the network.

Disallow root login remotely? [Y/n] Y
 ... Success!

By default, MariaDB comes with a database named 'test' that anyone can
access.  This is also intended only for testing, and should be removed
before moving into a production environment.

Remove test database and access to it? [Y/n] Y
 - Dropping test database...
 ... Success!
 - Removing privileges on test database...
 ... Success!

Reloading the privilege tables will ensure that all changes made so far
will take effect immediately.

Reload privilege tables now? [Y/n] Y
 ... Success!

Cleaning up...

All done!  If you've completed all of the above steps, your MariaDB
installation should now be secure.

Thanks for using MariaDB!
```

---

## 2. Create an admin

1. Check the listening port (which is for MariaDB server. as showed it the *status* previously): `netstat -ant | grep 3306`  

```bash
tcp        0      0 127.0.0.1:3306          0.0.0.0:*               LISTEN
```

2. Open the MariaDB prompt: `sudo mariadb`.  

```sh
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 37
Server version: 10.11.8-MariaDB-0ubuntu0.24.04.1 Ubuntu 24.04

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]>
```

3. Check for the existance of root users:  

```sql
SELECT User, Host FROM mysql.user WHERE User = 'root';

+------+-----------+
| User | Host      |
+------+-----------+
| root | localhost |
+------+-----------+
1 row in set (0.005 sec)
```

> Optional - change *root* to *admin*: `RENAME USER 'root'@'localhost' TO 'admin'@'localhost';`. (I'll stack with *root* foor now)  

Give the root privileges with ability to grant them to others and assign password:  

```sql
GRANT ALL ON *.* to 'root'@'localhost' IDENTIFIED BY '<password>' WITH GRANT OPTION;

Query OK, 0 rows affected (0.018 sec)
```

Reload the user privileges from the *mysql* system database into memory (to apply any modifications to user privileges immediately without restarting the database):  

```sql
FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.001 sec)
```

4. `EXIT;`  
5. Check status: `sudo systemctl status mariadb`  

```bash
● mariadb.service - MariaDB 10.11.8 database server
     Loaded: loaded (/usr/lib/systemd/system/mariadb.service; enabled; preset: enabled)
     Active: active (running) since Wed 2025-03-12 07:47:06 UTC; 39min ago
       Docs: man:mariadbd(8)
             https://mariadb.com/kb/en/library/systemd/
   Main PID: 15954 (mariadbd)
     Status: "Taking your SQL requests now..."
      Tasks: 10 (limit: 15026)
     Memory: 79.0M (peak: 81.6M)
        CPU: 1.799s
     CGroup: /system.slice/mariadb.service
             └─15954 /usr/sbin/mariadbd

Mar 12 07:47:05 userver mariadbd[15954]: 2025-03-12  7:47:05 0 [Note] Plugin 'FEEDBACK' is disabled.
Mar 12 07:47:05 userver mariadbd[15954]: 2025-03-12  7:47:05 0 [Note] InnoDB: Loading buffer pool(s) from /var/lib/mysql/ib_buffer_pool
Mar 12 07:47:05 userver mariadbd[15954]: 2025-03-12  7:47:05 0 [Warning] You need to use --log-bin to make --expire-logs-days or --binlog-expire-logs-seconds work.
Mar 12 07:47:05 userver mariadbd[15954]: 2025-03-12  7:47:05 0 [Note] Server socket created on IP: '127.0.0.1'.
Mar 12 07:47:05 userver mariadbd[15954]: 2025-03-12  7:47:05 0 [Note] InnoDB: Buffer pool(s) load completed at 250312  7:47:05
Mar 12 07:47:05 userver mariadbd[15954]: 2025-03-12  7:47:05 0 [Note] /usr/sbin/mariadbd: ready for connections.
Mar 12 07:47:05 userver mariadbd[15954]: Version: '10.11.8-MariaDB-0ubuntu0.24.04.1'  socket: '/run/mysqld/mysqld.sock'  port: 3306  Ubuntu 24.04
Mar 12 07:47:06 userver systemd[1]: Started mariadb.service - MariaDB 10.11.8 database server.
Mar 12 07:47:06 userver /etc/mysql/debian-start[15971]: Upgrading MariaDB tables if necessary.
Mar 12 07:47:06 userver /etc/mysql/debian-start[15982]: Checking for insecure root accounts.
```

---

## 3. Working with DB

### 1. Create a database with your name

> First, login with credentials from the previous step: `sudo mariadb -u root -p`. Running just the `sudo mariadb` will cause an error.  

```sql
CREATE DATABASE lians;
```

```sql
MariaDB [(none)]> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| lians              |
| mysql              |
| performance_schema |
| sys                |
+--------------------+

```

### 2. Create two tables

Create two tables: <span style="color: #db1a74">"Users"</span> and <span style="color: #db1a74">"Products"</span>. Each table should contain three field.  

1. Swich to created database: `USE lians;`  

2. Create tables  

```sql
CREATE TABLE Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username TEXT NOT NULL UNIQUE,
    cash DECIMAL(10, 2) NOT NULL DEFAULT 0
);

Query OK, 0 rows affected (0.061 sec)

CREATE TABLE Products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2)
);

Query OK, 0 rows affected (0.024 sec)

```

3. Check the creation.  

> There is an option to show details of some table in less detailed output also: `DESCRIBE <table_name>;`.

```sql
SHOW CREATE TABLE Users;

+--------------------------------------------------------------------+
| Table | Create Table |                                             |
+--------------------------------------------------------------------+
| Users | CREATE TABLE `Users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` text NOT NULL,
  `cash` decimal(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci |
+--------------------------------------------------------------------+

SHOW CREATE TABLE Products;

+--------------------------------------------------------------------+
| Table | Create Table |                                             |
+--------------------------------------------------------------------+
| Products | CREATE TABLE `Products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(100) NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci |
+--------------------------------------------------------------------+
```

> The *lians* DB doesn't have any relations between tables yet, so, it might be useful to have an *Purchases* table to relate user ids with the products' ids they've bought.  

### 3. Create a database dump

> Syntax for *dump*: `mysqldump -u <user> -p <database> > <db_backup>.sql`  

`mariadb-dump -u root -p lians > lians_backup.sql`.  

To verify: `ls -l lians_backup.sql`.  

```bash
-rw-rw-r-- 1 lians lians 2693 Mar 13 13:39 lians_backup.sql
```

### 4. Restore the data into a new database

1. Create a new DB for restoring:  

```sql
CREATE DATABASE lians_restore;

Query OK, 1 row affected (0.002 sec)

SHOW DATABASES;

+--------------------+
| Database           |
+--------------------+
| information_schema |
| lians              |
| lians_restore      |
| mysql              |
| performance_schema |
| sys                |
+--------------------+

EXIT;
```

2. Restore the *dump* into this new DB: `mariadb -u root -p lians_restore < lians_backup.sql`.  

3. Verify the successful restoring: login again with `sudo mariadb -u root -p`, then:  

```sql
USE lians_restore;
SHOW TABLES;

+-------------------------+
| Tables_in_lians_restore |
+-------------------------+
| Products                |
| Users                   |
+-------------------------+
2 rows in set (0.000 sec)
```

---

## Screenshots

The created [databases](https://drive.google.com/file/d/1gW5j8ANPoFn7ZmwmY4KD17WYYvZ_IShr/view?usp=drive_link).  
The structure of the [Users and Products](https://drive.google.com/file/d/15tnHKa0kbGn6EGZE0KRG3GXBZHt4CfCM/view?usp=drive_link)" tables.  
The [output](https://drive.google.com/file/d/1xITm2ES6p3KBziq8G5se-j6GEl7h1i-Q/view?usp=drive_link) confirming the successful creation of the database dump.  
The process of [restoring](https://drive.google.com/file/d/13LZTEG7CwoS2nqESoOHpuIcWVkENn-ta/view?usp=drive_link) data into the new database.  
The rest screenshots could be found [here](https://drive.google.com/drive/folders/1DdHsbwjrubOh6NrivPfwQaPy6O3W8tg3?usp=sharing).  
