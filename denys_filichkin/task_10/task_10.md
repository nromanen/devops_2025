[GD task 10](https://drive.google.com/drive/folders/1ZEo97cu0NgQMkJXBr0PMn-5IGxlzWKqh?usp=sharing)

Use the previously created virtual machine with Linux, ensure that it is powered on and accessible. Complete the following tasks focused on database server settings using command line tools.

- [x] Install MariaDB on Ubuntu Linux.
  - `sudo apt update`
  - `sudo apt install mariadb-server`
  - `sudo service mysql start`
  - `sudo service mysql status`
  - `sudo mysql -u root -p`
- [x] Create a database with your name
  - `CREATE DATABASE denys_fv;`
  - `SHOW DATABASES;`
- [x] Create two tables: "Users" and "Products". Each table should contain three fields.
  - `USE denys_fv;`
  - ```
    CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL);
    ```
  - ```
    CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL);
    ```
- [x ] Create a database dump.
  - `mysqldump -u root -p denys_fv > denys_fv_dump.sql`
- [x] Restore the data into a new database.
  - `SHOW DATABASES;`
  - `mysql -u root -p fv_denys < denys_fv_dump.sql`
  - `SHOW DATABASES;`
  - `USE fv_denys`
- [x] Provide screenshots and ensure they include the following crucial elements:
  - [x] The created database with your name.
    - [create db by my name](https://drive.google.com/file/d/1gnqmAXVtKJsiDs-ff5V58rbMUFd8lJUl/view?usp=drive_link)
    - [dbeaver and TablePlus](https://drive.google.com/file/d/1iRMk35rZeESqIB8a8NQH2gRmU7ia7Tj_/view?usp=drive_link)
  - [x] The structure of the "Users" and "Products" tables.
    - [create tables](https://drive.google.com/file/d/1dncRfnrZq6zmnwN8iSO_5n_K_O88vMYJ/view?usp=drive_link)
    - [dbeaver and TablePlus](https://drive.google.com/file/d/1NbHnzP2l6xQwb2nd5_adcRZlXHXtjayw/view?usp=drive_link)
  - [x] The output confirming the successful creation of the database dump.
    - [create dump](https://drive.google.com/file/d/1LlfiOW_vK_J8J5AutRWW2BHgYdaHBmSG/view?usp=drive_link)
    - [create dump](https://drive.google.com/file/d/10J4teKZj62XsY6SiEGYISCilINvxqUZ5/view?usp=drive_link)
  - [x] The process of restoring the data into the new database.
    - [create new db_name](https://drive.google.com/file/d/1z00FYpzbsf7Z0RXxd_XpJvRLsUkXuwW-/view?usp=drive_link)
    - [restore db](https://drive.google.com/file/d/1pW9q3916NNBZchiypIFT7AN89Vcbsy-V/view?usp=drive_link)
