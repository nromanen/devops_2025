## Installation of Virtual Machines

1. **VM1**: Load balancer (_Nginx_) - `192.168.178.69`
2. **VM2**: Web Server1 (_Apache, PHP, Wordpress_) - `192.168.178.70
3. **VM3**: Web Server2 (_Apache, PHP, Wordpress_) - `192.168.178.71
4. **VM4**: DataBase (_MySQL_) - `192.168.178.72

#### 1. Nginx settings - (VM1)

**File: `/etc/nginx/sites-available/load-balancer`**
```bash
upstream wordpress_cluster {
    server 192.168.178.70:80 weight=1;
    server 192.168.178.71:80 weight=1;
}

server {
    listen 80;

    server_name 192.168.178.69;

    location / {
        proxy_pass http://wordpress_cluster;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```
#### 2. Web Servers and Wordpress settings - (VM2 & VM3)

 - Both Web servers have same settings
```
<VirtualHost *:80>
	DocumentRoot /var/www/html
	
    <Directory /var/www/html>
        AllowOverride All
        Require all granted
    </Directory>

	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined

</VirtualHost>
```

- **wp-config.php**
```php
define('DB_NAME', 'wordpress');
define('DB_USER', 'wpuser');
define('DB_PASSWORD', '111pass222');
define('DB_HOST', '192.168.178.72'); //IP of DB server
```

- created `front-page.php` for Wordpress1:
```php
<?php
get_header();
echo "<h1>WP1 - 192.168.178.70</h1>"; // IP of VM2
get_footer();
?>
```

- created `front-page.php` for Wordpress2:
```php
<?php
get_header();
echo "<h1>WP2 - 192.168.178.71</h1>"; // IP of VM3
get_footer();
?>
```

#### 3. MySQL settings - (VM4)

- create database, user and credentials:
```sql
CREATE DATABASE wordpress;
CREATE USER 'wpuser'@'%' IDENTIFIED BY 'wp_pass';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';
FLUSH PRIVILEGES;
EXIT;
```

- edit `/etc/mysql/mysql.conf.d/mysqld.cnf`
```bash
bind-address = 0.0.0.0
```


#### Results - _When the page is refreshed, responses arrive sequentially from different WordPress installations_

- [Response from Wordpress 1 - (VM2)](https://drive.google.com/file/d/1uzR1h4reGER69QtmVsU9a6eHQDFbP13v/view?usp=sharing)
- [Response from Wordpress 2 - (VM3)](https://drive.google.com/file/d/1oUPi4MxueHunbJLwspqWtRESovTvBZDd/view?usp=sharing)