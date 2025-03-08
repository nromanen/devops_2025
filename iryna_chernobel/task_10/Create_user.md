# Task 10: Create user for remote connect to database

> Виконала [@Ir04ka7](https://https:github.com/Ir04ka7) (Iryna Chernobel)


### 1. Зайти в MariaDB під користувачем root
```
sudo mariadb
```
### 2. Створення бази даних `sofserve_database`
```
CREATE DATABASE sofserve_database;

```
### 3. Створення нового користувача `sofserve_user`
```
CREATE USER 'sofserve_user'@'%' IDENTIFIED BY 'password';
```
### 4. Видаємо користувачеві `sofserve_user` відповідні права для бази даних
```
GRANT ALL ON sofserve_database.* TO 'sofserve_user'@'%';
FLUSH PRIVILEGES;
```
### 5. Перевірка доступу користувача до бази даних

- Увійти в MariaDB під створеним користувачем 

mariadb -u sofserve_user -p

- Перевірити, які бази даних бачить користувач


SHOW DATABASES;


| Database          |
| ----- |
| information_schema |
| sofserve_database |

---