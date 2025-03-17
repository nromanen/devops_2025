# 12 Task on Nginx Load Balancer

 
## ОС та розміщення сайтів


- **VM1**: Ubuntu 22.04 (Nginx Load Balancer) — `192.168.0.187/24`

- **VM2**: Ubuntu 24.04 (WordPress Server 1) — `192.168.0.198/24` — сайт **CreativeMind** на WordPress *(налаштований у попередньому завданні)*

- **VM3**: Ubuntu 22.04 (WordPress Server 2) — `192.168.0.193/24` — сайт **My life** на WordPress

---

## 1. Встановлення WordPress на VM2 і VM3

### 1.1 Встановлення Apache, PHP, MariaDB клієнта
```
sudo apt update
sudo apt install apache2 php php-mysql mariadb-client wget unzip -y
```

### 1.2 Завантаження та встановлення WordPress
```
cd /tmp
wget https://wordpress.org/latest.zip
unzip latest.zip
sudo mv wordpress /var/www/html/
sudo chown -R www-data:www-data /var/www/html/wordpress
```

### 1.3 Налаштування бази даних

#### VM2 (192.168.0.198)
```
CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY '*****';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';
FLUSH PRIVILEGES;
```

#### VM3 (192.168.0.193)
```
CREATE DATABASE wordpress2 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'wpuser2'@'localhost' IDENTIFIED BY '*****';
GRANT ALL PRIVILEGES ON wordpress2.* TO 'wpuser2'@'localhost';
FLUSH PRIVILEGES;
```

### 1.4 Налаштування `wp-config.php`

#### VM2
```
define( 'DB_NAME', 'wordpress' );
define( 'DB_USER', 'wpuser' );
define( 'DB_PASSWORD', '*****' );
define( 'DB_HOST', 'localhost' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
```

#### VM3
```
define( 'DB_NAME', 'wordpress2' );
define( 'DB_USER', 'wpuser2' );
define( 'DB_PASSWORD', '******' );
define( 'DB_HOST', 'localhost' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
```

### 1.5 Перевірка WordPress

```
curl http://192.168.0.198/wordpress
curl http://192.168.0.193/wordpress
```

---

## 2. Налаштування Nginx на VM1 (192.168.0.187)

### Файл: `/etc/nginx/sites-available/default`

```
upstream wordpress_servers {
    server 192.168.0.198;
    server 192.168.0.193;
}

server {
    listen 80;
    server_name localhost;

    location / {
        proxy_pass http://wordpress_servers;
    }
}
```

```
sudo nginx -t
sudo systemctl restart nginx
```

---

## 3. Перевірка результату

Перейти в браузері на:
```
http://192.168.0.187/wordpress
```

WordPress-сайти відкриваються по черзі (балансування між VM2 і VM3).

---

## 4. Скріншоти

- [конфігурація Nginx (VM1)](https://drive.google.com/drive/folders/1xfMoOQ5Qf1Dts1Kdet-oFt0rxwNQnzla?usp=drive_link)
- [WordPress на VM2](https://drive.google.com/drive/folders/12oZ7-6Rckx8Bepn_FGgoWToIcSppGT4V?usp=drive_link)
- [WordPress на VM3](https://drive.google.com/drive/folders/164daCsJ0yFK9VvhL8fgTl79a_wyFa96O?usp=drive_link)
- [Wordpress.png` — чергування WordPress-сайтів через Nginx](https://drive.google.com/drive/folders/1K2zywytU3o-SKUHLiV7L7OsztYUgg_NS?usp=drive_link)