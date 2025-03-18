# WordPress Deployment on 2 vms
## 1: Setting Up the Web Server**

### **Install Required Packages**
```bash
sudo dnf install -y httpd php php-mysqlnd
```

### **Start and Enable Apache**
```bash
sudo systemctl start httpd
sudo systemctl enable httpd
```

### **Download and Configure WordPress**
```bash
cd /var/www/html
sudo curl -O https://wordpress.org/latest.tar.gz
sudo tar -xvzf latest.tar.gz
sudo mv wordpress/* .
sudo rm -rf wordpress latest.tar.gz
```

### **Set Correct Permissions**
```bash
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html
```

---

## 2: Setting Up the Database Server**

### **Install MySQL**
```bash
sudo dnf install -y mysql-server
```

### **Start and Enable MySQL**
```bash
sudo systemctl start mysqld
sudo systemctl enable mysqld
```

### **Create WordPress Database and User**
```bash
mysql -u root -p
```
Then inside the MySQL shell:
```sql
CREATE DATABASE wordpress;
CREATE USER 'wordpressuser'@'%' IDENTIFIED BY 'StrongPass123!';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'%';
FLUSH PRIVILEGES;
EXIT;
```

### **Allow Remote Connections**
Edit MySQL config file (`/etc/my.cnf` or `/etc/mysql/mysql.conf.d/mysqld.cnf`) and set:
```ini
bind-address = 0.0.0.0
```
Then restart MySQL:
```bash
sudo systemctl restart mysqld
```

---

## **Step 3: Configuring WordPress to Connect to the Database Server**

### **Edit wp-config.php**
```bash
sudo nano /var/www/html/wp-config.php
```
Set the following database details:
```php
define( 'DB_NAME', 'wordpress' );
define( 'DB_USER', 'wordpressuser' );
define( 'DB_PASSWORD', 'StrongPass123!' );
define( 'DB_HOST', '192.168.64.7' ); 
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
```

### **Enable Apache to Connect to MySQL Over Network (SELinux Fix)**
```bash
sudo setsebool -P httpd_can_network_connect_db 1
```

### **Restart Apache**
```bash
sudo systemctl restart httpd
```

---

## **Step 4: Verifying Setup**

```bash
curl http://192.168.64.6
```
WordPress is working correctly, we see an HTML response

2 vms: https://drive.google.com/file/d/1NZUjszsULVXg6O-73pQis9mydQPDOnij/view?usp=sharing

In browser: https://drive.google.com/file/d/1S9p7qbsdv-pbiwcXXpAcYZUJ2LDnLDwJ/view?usp=sharing
---