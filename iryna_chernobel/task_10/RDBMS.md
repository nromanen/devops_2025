# Task 10: RDBMS
> Виконала [@Ir04ka7](https://https:github.com/Ir04ka7) (Iryna Chernobel)

#### Оновлення інформації про доступні пакети
```
sudo apt update
```
## 1. Встановлення MariaDB
```
sudo apt install mariadb-server -y
sudo systemctl status mariadb
```

###  Перевірка, чи MariaDB слухає порт 3306
```
netstat -ant | grep 3306
sudo mariadb
```
## 2. Створення користувача та призначення йому всіх привілеїв
```
CREATE USER 'iryna'@'localhost' IDENTIFIED BY *******';
GRANT ALL PRIVILEGES ON *.* TO 'iryna'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```
Screanshot: https://drive.google.com/file/d/1HESwjXnnZjbTrnSoHzKCxqKxGHYhvI7n/view?usp=drive_link

### Перевірка привілеїв
```
SHOW GRANTS FOR 'iryna'@'localhost';
EXIT;
sudo systemctl status mariadb
scren creat maria
```
## 3. Успішний вхід під користувачем `iryna`
```
mariadb -u  iryna-p
```
## 4. Створення бази даних `iryna_ch`

CREATE DATABASE  iryna_ch

| Database            |
| ---|
| information_schema |
| iryna_ch           |
| mysql              |
| performance_schema |
| sys                |

Screanshot: https://drive.google.com/file/d/1K-1EVU2y1CPOKntqUwdc7tSkk0Ho4BIF/view?usp=drive_link
 
 
## 5. Створення таблиць `Users` та `Products`

CREATE TABLE Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);


| Field  | Type         | Null | Key | Default | Extra          |
| --- | --- | -- | --- | --- | ---|
| id     | int(11)      | NO   | PRI | NULL    | auto_increment |
| name   | varchar(100) | YES  |     | NULL    |                |
| email  | varchar(100) | YES  |     | NULL    |                |


CREATE TABLE Products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2)
);


| Field  | Type         | Null | Key | Default | Extra          |
| --- | --- | -- | --- | --- | ---|
| id     | int(11)      | NO   | PRI | NULL    | auto_increment |
| name   | varchar(100) | YES  |     | NULL    |                |
| price  | decimal(10,2)| YES  |     | NULL    |                |


Screanshot: https://drive.google.com/file/d/1H3WT5UGMoLzFKvUSoa0GnjKsZ1oAlbhV/view?usp=drive_link

## 6. Створення дампу бази даних
```
mysqldump -u iryna -p iryna_ch > iryna_ch_dump.sql
```
## 7. Створення нової бази `new_iryna_ch` та її відновлення
```
mariadb -u iryna -p -e "CREATE DATABASE new_iryna_ch;"
```
Screanshot: https://drive.google.com/file/d/1CTSWfSh__G2LU30XY1sjbD7nbK4Bv6Vb/view?usp=drive_link
```
mysql -u iryna -p new_iryna_ch < iryna_ch_dump.sql
mariadb -u iryna -p -e "USE new_iryna_ch; SHOW TABLES;"
```

Screanshot: https://drive.google.com/file/d/1cXJHHEx3PTMWxM1_TwjTvatQR54To7Ez/view?usp=drive_link

---
### All Screanshots :https://drive.google.com/drive/folders/1nc9hjv3La5JIEd37Lq1NgNdIYLQOh0X_?usp=drive_link