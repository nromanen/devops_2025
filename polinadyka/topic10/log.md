# RDBMS

1. Install MariaDB
```BASH
sudo apt update
sudo apt install mariadb-server -y
```
2. Log into MariaDB
```bash
polina@ubuntu:~$ sudo mysql -u root -p
Enter password: 
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 31
Server version: 10.11.8-MariaDB-0ubuntu0.24.04.1 Ubuntu 24.04

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> 
```
3. Create a Database with Your Name
```bash
MariaDB [(none)]> CREATE DATABASE polina_db;
Query OK, 1 row affected (0.001 sec)

MariaDB [(none)]> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| polina_db          |
| sys                |
+--------------------+
5 rows in set (0.004 sec)

MariaDB [(none)]> 
```
4. Create two tables: "Users" and "Products". Each table should contain three fields.

```bash
MariaDB [(none)]> CREATE DATABASE polina_db;
Query OK, 1 row affected (0.001 sec)

MariaDB [(none)]> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| polina_db          |
| sys                |
+--------------------+
5 rows in set (0.004 sec)

MariaDB [(none)]> USE polina_db;
Database changed
MariaDB [polina_db]> CREATE TABLE Users (
    ->     id INT AUTO_INCREMENT PRIMARY KEY,
    ->     name VARCHAR(100) NOT NULL,
    ->     email VARCHAR(100) UNIQUE NOT NULL
    -> );
Query OK, 0 rows affected (0.017 sec)

MariaDB [polina_db]> CREATE TABLE Products (
    ->     id INT AUTO_INCREMENT PRIMARY KEY,
    ->     product_name VARCHAR(100) NOT NULL,
    ->     price DECIMAL(10,2) NOT NULL
    -> );
Query OK, 0 rows affected (0.009 sec)

MariaDB [polina_db]> SHOW TABLES;
+---------------------+
| Tables_in_polina_db |
+---------------------+
| Products            |
| Users               |
+---------------------+
2 rows in set (0.002 sec)

MariaDB [polina_db]> DESCRIBE Users;
+-------+--------------+------+-----+---------+----------------+
| Field | Type         | Null | Key | Default | Extra          |
+-------+--------------+------+-----+---------+----------------+
| id    | int(11)      | NO   | PRI | NULL    | auto_increment |
| name  | varchar(100) | NO   |     | NULL    |                |
| email | varchar(100) | NO   | UNI | NULL    |                |
+-------+--------------+------+-----+---------+----------------+
3 rows in set (0.003 sec)

MariaDB [polina_db]> DESCRIBE Products;
+--------------+---------------+------+-----+---------+----------------+
| Field        | Type          | Null | Key | Default | Extra          |
+--------------+---------------+------+-----+---------+----------------+
| id           | int(11)       | NO   | PRI | NULL    | auto_increment |
| product_name | varchar(100)  | NO   |     | NULL    |                |
| price        | decimal(10,2) | NO   |     | NULL    |                |
+--------------+---------------+------+-----+---------+----------------+
3 rows in set (0.002 sec)

MariaDB [polina_db]> 
```
5. Create a Database Dump
```bash
polina@ubuntu:~$ sudo mysqldump -u root polina_db > polina_db_backup.sql
polina@ubuntu:~$ ls -lh polina_db_backup.sql
-rw-rw-r-- 1 polina polina 2.7K Mar 12 18:17 polina_db_backup.sql
```
6. Restore the Data into a New Database
```bash
polina@ubuntu:~$ sudo mysql -u root -p -e "CREATE DATABASE polina_db_restored;"
Enter password: 
polina@ubuntu:~$ sudo mysql -u root polina_db_restored < polina_db_backup.sql
polina@ubuntu:~$ sudo mysql -u root -p -e "SHOW TABLES FROM polina_db_restored;"
Enter password: 
+------------------------------+
| Tables_in_polina_db_restored |
+------------------------------+
| Products                     |
| Users                        |
+------------------------------+
```
---

Screenshots: https://drive.google.com/drive/folders/1O0abNLE7_e_pFlukQOkt-h9PW-xqPuL6?usp=sharing