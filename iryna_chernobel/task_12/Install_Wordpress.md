# Task 12: Install Wordpress

## KillerCoda середовища

- Запусти середовище на KillerCoda, виконайте завдання:
👉 [ KillerCoda](https://killercoda.com/online-marathon/course/DevOps_dev/Setup_LAMP)

- [Встановити Apache](https://drive.google.com/file/d/1rVwSLWPPwcX89QIhuoXaT7b5SCOklE56/view?usp=drive_link)
- [Налаштувати PHP 8.2](https://drive.google.com/file/d/1KrlGyWp2FCszbww-px3ddk6i3SDCfTpK/view?usp=drive_link)
- [Встановити MariaDB](https://drive.google.com/file/d/1J1XF-koNG_6EoQiB63fw18Y--TI8GZKK/view?usp=drive_link)




# Встановлення WordPress на дві окремі машини (веб-сервер + база даних)

## ОС:

- **Машина 1**: Ubuntu 22.04 (веб-сервер) IP: 192.168.0.198

- **Машина 2**: Ubuntu 24.04 (сервер бази даних) IP: 192.168.0.193

---

# Машина 1: Веб-сервер (IP: 192.168.0.198)

### Встановлення Apache та PHP

```
sudo apt update
sudo apt install apache2 php php-mysql libapache2-mod-php -y
```

### Налаштування Apache

Створено конфіг файл для WordPress :

```
sudo nano /etc/apache2/sites-available/000-default.conf
```

Змінено `DocumentRoot` на `/var/www/html/wordpress`

```
<Directory /var/www/html/wordpress>
    AllowOverride All
</Directory>
```

Перезапуск Apache:

```
sudo systemctl restart apache2
```

### Завантаження та встановлення `WordPress`

```
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
sudo mkdir -p /var/www/html
sudo mv wordpress /var/www/html/
sudo chown -R www-data:www-data /var/www/html/wordpress
```

### Налаштування файлу `wp-config.php`

```
define('DB_NAME', 'wordpress');
define('DB_USER', 'wpuser');
define('DB_PASSWORD', '******');
define('DB_HOST', '192.168.0.193');
```

---

# Машина 2: Сервер бази даних (IP: 192.168.0.193)

### Встановлення MariaDB

```
sudo apt update
sudo apt install mariadb-server -y
```

### Налаштування зовнішнього доступу

```
sudo nano /etc/mysql/mariadb.conf.d/50-server.cnf
```

Змінено рядок:

```
bind-address = 0.0.0.0
```

Перезапуск :

```
sudo systemctl restart mariadb

```

### Створення бази даних і користувача

```
CREATE DATABASE wordpress;
CREATE USER 'wpuser'@'192.168.0.198' IDENTIFIED BY '******';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'192.168.0.198';
FLUSH PRIVILEGES;
```

### Перевірка підключення з веб-сервера

```
mysql -h 192.168.0.193 -u wpuser -p
```

---

## Перевірка результату

- [x] Функціонуючий сайт на WordPress — відкрито в браузері 

```
http://192.168.0.198/wordpress
```

- WordPress успішно підключено до віддаленої бази даних
- Доступ до керування сайтом — за адресою /wp-admin

---

## Screanshot:

- [Робочий сайт WordPress](https://drive.google.com/file/d/1lnMSlaflNVnjtKNA-KRw6HGthXSv-Odp/view?usp=drive_link)
- [Встановлена база даних з користувачем](https://drive.google.com/file/d/10FKROu5d3HJpPoxMvXIVnDQQW1xSm4sa/view?usp=drive_link)
- [Налаштовання Машини 1  (веб-сервер)](_https://drive.google.com/drive/folders/164daCsJ0yFK9VvhL8fgTl79a_wyFa96O?usp=drive_link)
- [Налаштовання Машини 2  (сервер бази даних)](https://drive.google.com/drive/folders/1RTldwFhvjz1s3InFUHBptrspALcxttsR?usp=drive_link)
- [WordPress](https://drive.google.com/drive/folders/1_QEJW-Q8r58LiGEXgFVYCF4jjeQTFYkJ?usp=drive_link)

---