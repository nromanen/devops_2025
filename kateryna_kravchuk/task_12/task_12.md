# Task 12: Install Wordpress

> Done by [@Lians-coder](https://github.com/Lians-coder) (Kateryna Kravchuk)

---

## Task 1: Killercoda

Complete the task on KillerCoda by visiting [this link](https://killercoda.com/online-marathon/course/DevOps_dev/Setup_LAMP).  

### 1.1. Install Apache

1. Install Apache

```bash
sudo apt update
sudo apt install apache2 -y
```

2. Configure firewall

```bash
sudo ufw app list
sudo ufw allow in "Apache"
sudo ufw status
```

### 1.2. Install PHP

```bash
sudo apt install -y lsb-release gnupg2 ca-certificates apt-transport-https software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt -y install php8.2 php8.2-mysql php8.2-gd php8.2-ldap php8.2-odbc  php8.2-xml php8.2-xmlrpc php8.2-mbstring php8.2-snmp php8.2-soap curl 
php -v
```

### 1.3. Install and configure MariaDB

1. Install securely *MariaDB* server and verify.  

```bash
sudo apt install mariadb-server -y
sudo mysql_secure_installation
sudo systemctl status mariadb
sudo mariadb
```

2. Make two root users (for local and remote access) with grant options.  

```sql
GRANT ALL ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'password' WITH GRANT OPTION;
GRANT ALL ON *.* TO 'ruser'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EXIT;
```

3. Add new rules for the firewall.  

```bash
sudo ufw allow 3306
sudo ufw reload
mariadb -u ruser -p
```

4. Create a new database and add some information to it.  

```sql
CREATE DATABASE newdb;
SHOW DATABASES;
USE newdb;

CREATE TABLE softserve ( 
    id INT(5) NOT NULL AUTO_INCREMENT, 
    name VARCHAR(30) NULL DEFAULT NULL, 
    phone VARCHAR(12) NULL DEFAULT NULL,
    level TINYINT(2) NULL DEFAULT NULL, 
    PRIMARY KEY (id)) 
    ENGINE=InnoDB  
    DEFAULT CHARSET=utf8mb4;

INSERT INTO softserve (name, phone, level) 
    VALUES 
        ('Don', '123456789123', '2'),  
        ('Etta', '568569874521', '3'),  
        ('Irma', '987654321741', '0'),
        ('Barbara', '234567891789', '1'),  
        ('Gladys', '325647897412', '2');

SELECT * FROM softserve ORDER BY name ASC;
EXIT;
```

### 1.4. Test server

1. Create a PHP file to run on a server.  

```bash
sudo touch /var/www/html/index.php
sudo nano /var/www/html/index.php
```

2. Put inside that file:  

```php
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<body>
<?php

$hostname = "localhost";
$username = "ruser";
$password = "password";
$db = "newdb";

$dbconnect=mysqli_connect($hostname,$username,$password,$db);

if ($dbconnect->connect_error) {
  die("Database connection failed: " . $dbconnect->connect_error);
}

?>
  <figure>
    <img src="https://upload.wikimedia.org/wikipedia/commons/e/e3/SoftServe.svg" />
    <figcaption>
      <a href="https://upload.wikimedia.org/wikipedia/commons/e/e3/SoftServe.svg">SoftServe</a>, 
      <a href="https://creativecommons.org/licenses/by/2.0">CC BY 2.0</a>, via Wikimedia Commons
    </figcaption>
  </figure>
  </a>
<table border="1" align="center">
<tr>
  <td>Reviewer Name</td>
  <td>Phone</td>
  <td>Level</td>
</tr>

<?php

$query = mysqli_query($dbconnect, "SELECT * FROM softserve")
   or die (mysqli_error($dbconnect));

while ($row = mysqli_fetch_array($query)) {
  echo
   " <tr>
    <td>{$row['name']}</td>
    <td>{$row['phone']}</td>
    <td>{$row['level']}</td>
   </tr>\n";

}

?>
</table>
</body>
</html>
```

3. Delete default *index* file and change permissions to run a new one:  

```bash
sudo rm /var/www/html/index.html
sudo chmod 755 /var/www/html/index.php
sudo chown www-data:www-data /var/www/html/index.php
```

---

## Task 2: Virtual machine

### 2.0. Preparation

Description on how to get access to the **Oracle Linux 9** as a VM can be found [here](https://github.com/nromanen/devops_2025/blob/main/kateryna_kravchuk/task_03/task_03.md#preparation).  

#### 2.0.1 Initialization

For the purpose of this task, create different *Vagrantfile* that will be providing two virtual machines: `vagrant init`.  

```txt
A `Vagrantfile` has been placed in this directory. You are now
ready to `vagrant up` your first virtual environment! Please read
the comments in the Vagrantfile as well as documentation on
`vagrantup.com` for more information on using Vagrant.
```

#### 2.0.2 Basic configuration

> Most installation steps could be appointed in the configuration file immediately, but it was deliberately missed to be done later according to the task.  

Update *Vagrantfile* to match the following:  

```ruby
Vagrant.configure("2") do |config|

  config.vm.define "web" do |web|
    web.vm.box = "oraclelinux/9"
    web.vm.box_url = "https://oracle.github.io/vagrant-projects/boxes/oraclelinux/9.json"
    web.vm.hostname = "webserver"
    web.vm.network "private_network", ip: "192.168.33.10"
    web.vm.provider "virtualbox" do |vb|
      vb.memory = 2048
      vb.cpus = 1
    end
  end

  config.vm.define "db" do |db|
    db.vm.box = "oraclelinux/9"
    db.vm.box_url = "https://oracle.github.io/vagrant-projects/boxes/oraclelinux/9.json"
    db.vm.hostname = "dbserver"
    db.vm.network "private_network", ip: "192.168.33.11"
    db.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 1
    end
  end

end
```

#### 2.0.3 Connect to VMs

To start both machines: `vagrant up`, to start individually: `vagrant up <vm_name>` (e.g., `vagrant up web`).  
To connect to the desired VM, run `vagrant ssh <vm_name>`.  

### 2.1. Install Apache

> The next steps should be run on the *webserver* machine only.  

#### 1. Install: `sudo yum -y install httpd`  

```bash
Installed:
  apr-1.7.0-12.el9_3.x86_64          apr-util-1.6.1-23.el9.x86_64             apr-util-bdb-1.6.1-23.el9.x86_64               apr-util-openssl-1.6.1-23.el9.x86_64
  httpd-2.4.62-1.0.1.el9_5.2.x86_64  httpd-core-2.4.62-1.0.1.el9_5.2.x86_64   httpd-filesystem-2.4.62-1.0.1.el9_5.2.noarch   httpd-tools-2.4.62-1.0.1.el9_5.2.x86_64 mailcap-2.1.49-5.el9.noarch
  mod_http2-2.0.26-2.el9_4.1.x86_64  mod_lua-2.4.62-1.0.1.el9_5.2.x86_64      oracle-logos-httpd-90.2-1.0.4.el9.noarch  

Complete!
```

#### 2. Start and enable

Start: `sudo systemctl start httpd`  

> The absence of output confirms success.  

Enable on the boot: `sudo systemctl enable httpd`  

```bash
Created symlink /etc/systemd/system/multi-user.target.wants/httpd.service → /usr/lib/systemd/system/httpd.service.
```

#### 3. Verify running: `sudo systemctl status httpd`  

```bash
● httpd.service - The Apache HTTP Server
     Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; preset: disabled)
     Active: active (running) since Tue 2025-03-18 18:39:31 UTC; 41s ago
       Docs: man:httpd.service(8)
   Main PID: 15444 (httpd)
     Status: "Total requests: 0; Idle/Busy workers 100/0;Requests/sec: 0; Bytes served/sec:   0 B/sec"
      Tasks: 177 (limit: 12200)
     Memory: 20.9M
        CPU: 142ms
     CGroup: /system.slice/httpd.service
             ├─15444 /usr/sbin/httpd -DFOREGROUND
             ├─15445 /usr/sbin/httpd -DFOREGROUND
             ├─15446 /usr/sbin/httpd -DFOREGROUND
             ├─15447 /usr/sbin/httpd -DFOREGROUND
             └─15448 /usr/sbin/httpd -DFOREGROUND
             
Mar 18 18:39:31 webserver systemd[1]: Starting The Apache HTTP Server...
Mar 18 18:39:31 webserver httpd[15444]: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 127.0.1.1. Set the 'ServerName' directive globally to suppress this message
Mar 18 18:39:31 webserver systemd[1]: Started The Apache HTTP Server.
Mar 18 18:39:32 webserver httpd[15444]: Server configured, listening on: port 80
```

#### 4. Configure firewall

> Start *firewalld* process if not already: `sudo systemctl start firewalld`.  

```bash
sudo firewall-cmd --add-service=http --permanent
sudo firewall-cmd --add-service=https --permanent
sudo firewall-cmd --reload
```

Each command should output **success**.  

#### 5. Enable `mod_rewrite`

Change **AllowOverride** *None* to *All* in the `httpd.conf` file:  

> To verify the module is *enabled*: `sudo httpd -M | grep rewrite`. The desired output is `rewrite_module (shared)`.  
> `mod_rewrite` is configured by `<Directory "/var/www/html">` directive, so it's a section to modify.  

```bash
sudo nano /etc/httpd/conf/httpd.conf
sudo systemctl restart httpd
```

### 2.2. Install PHP

1. Install PHP and dependencies:  

```bash
sudo dnf install -y php php-mysqlnd php-fpm php-json php-gd php-xml php-mbstring php-curl php-ldap php-odbc unzip curl
```

```txt
Installed:
  fontconfig-2.14.0-2.el9_1.x86_64    gd-2.3.2-3.el9.x86_64                jbigkit-libs-2.1-23.el9.x86_64      libX11-1.7.0-9.el9.x86_64          libX11-common-1.7.0-9.el9.noarch
  libXau-1.0.9-8.el9.x86_64           libXpm-3.5.13-10.el9.x86_64          libjpeg-turbo-2.0.90-7.el9.x86_64   libtiff-4.4.0-13.el9.x86_64        libtool-ltdl-2.4.6-46.el9.x86_64    
  libwebp-1.2.0-8.el9_3.x86_64        libxcb-1.13.1-9.el9.x86_64           libxslt-1.1.34-9.0.1.el9.x86_64     nginx-filesystem-2:1.20.1-20.0.1.el9.noarch    
  php-8.0.30-1.el9_2.x86_64           php-cli-8.0.30-1.el9_2.x86_64        php-common-8.0.30-1.el9_2.x86_64    php-fpm-8.0.30-1.el9_2.x86_64      php-gd-8.0.30-1.el9_2.x86_64        
  php-ldap-8.0.30-1.el9_2.x86_64      php-mbstring-8.0.30-1.el9_2.x86_64   php-mysqlnd-8.0.30-1.el9_2.x86_64   php-odbc-8.0.30-1.el9_2.x86_64     php-opcache-8.0.30-1.el9_2.x86_64
  php-pdo-8.0.30-1.el9_2.x86_64       php-xml-8.0.30-1.el9_2.x86_64        unixODBC-2.3.9-4.el9.x86_64         unzip-6.0-57.0.1.el9.x86_64        xml-common-0.6.3-58.el9.noarch

Complete!
```

2. Verify: `php -v`.  

```bash
PHP 8.0.30 (cli) (built: Aug  3 2023 17:13:08) ( NTS gcc x86_64 )
Copyright (c) The PHP Group
Zend Engine v4.0.30, Copyright (c) Zend Technologies
    with Zend OPcache v8.0.30, Copyright (c), by Zend Technologies
```

#### Notes on PHP

*Oracle Linux 9* ships with **PHP 8.0** from the default **AppStream** repository. Use the **Remi** repository for the newer version:  

```bash
sudo dnf install -y epel-release
sudo dnf install -y dnf-utils
sudo dnf install -y https://rpms.remirepo.net/enterprise/remi-release-9.rpm
```

Check the available PHP versions: `dnf module list php`. Then enable desired version (e.g., 8.2):  

```bash
sudo dnf module reset php
sudo dnf module enable php:remi-8.2
```

Verify by `php -v`.  
Restart Apache with `sudo systemctl restart httpd`.  

### 2.3. Install MySQL

> The following should be run on the *dbserver* machine.  

#### 1.1. Install *MySQL*: `sudo dnf install -y mysql-server`

```txt
Installed:
  checkpolicy-3.6-1.el9.x86_64                libicu-67.1-9.el9.x86_64                      libtirpc-1.3.3-9.el9.x86_64                       mariadb-connector-c-config-3.2.6-1.el9_0.noarch
  mecab-0.996-3.el9.4.x86_64                  mysql-8.0.41-2.el9_5.x86_64                   mysql-common-8.0.41-2.el9_5.x86_64                mysql-errmsg-8.0.41-2.el9_5.x86_64                mysql-selinux-1.0.13-1.el9_5.noarch         mysql-server-8.0.41-2.el9_5.x86_64            perl-AutoLoader-5.74-481.el9.noarch               perl-B-1.80-481.el9.x86_64
  perl-Carp-1.50-460.el9.noarch               perl-Class-Struct-0.66-481.el9.noarch         perl-Data-Dumper-2.174-462.el9.x86_64             perl-Digest-1.19-4.el9.noarch 
  perl-Digest-MD5-2.58-4.el9.x86_64           perl-Encode-4:3.08-462.el9.x86_64             perl-Errno-1.30-481.el9.x86_64                    perl-Exporter-5.74-461.el9.noarch
  perl-Fcntl-1.13-481.el9.x86_64              perl-File-Basename-2.85-481.el9.noarch        perl-File-Path-2.18-4.el9.noarch                  perl-File-Temp-1:0.231.100-4.el9.noarch
  perl-File-stat-1.09-481.el9.noarch          perl-FileHandle-2.03-481.el9.noarch           perl-Getopt-Long-1:2.52-4.el9.noarch              perl-Getopt-Std-1.12-481.el9.noarch   
  perl-HTTP-Tiny-0.076-462.el9.noarch         perl-IO-1.43-481.el9.x86_64                   perl-IO-Socket-IP-0.41-5.el9.noarch               perl-IO-Socket-SSL-2.073-2.el9.noarch  
  perl-IPC-Open3-1.21-481.el9.noarch          perl-MIME-Base64-3.16-4.el9.x86_64            perl-Mozilla-CA-20200520-6.el9.noarch             perl-NDBM_File-1.15-481.el9.x86_64     
  perl-Net-SSLeay-1.94-1.el9.x86_64           perl-POSIX-1.94-481.el9.x86_64                perl-PathTools-3.78-461.el9.x86_64                perl-Pod-Escapes-1:1.07-460.el9.noarch     
  perl-Pod-Perldoc-3.28.01-461.el9.noarch     perl-Pod-Simple-1:3.42-4.el9.noarch           perl-Pod-Usage-4:2.01-4.el9.noarch                perl-Scalar-List-Utils-4:1.56-462.el9.x86_64 
  perl-SelectSaver-1.02-481.el9.noarch        perl-Socket-4:2.031-4.el9.x86_64              perl-Storable-1:3.21-460.el9.x86_64               perl-Symbol-1.08-481.el9.noarch 
  perl-Term-ANSIColor-5.01-461.el9.noarch     perl-Term-Cap-1.17-460.el9.noarch             perl-Text-ParseWords-3.30-460.el9.noarch          perl-Text-Tabs+Wrap-2013.0523-460.el9.noarch   
  perl-Time-Local-2:1.300-7.el9.noarch        perl-URI-5.09-3.el9.noarch                    perl-base-2.27-481.el9.noarch                     perl-constant-1.33-461.el9.noarch        
  perl-if-0.60.800-481.el9.noarch             perl-interpreter-4:5.32.1-481.el9.x86_64      perl-libnet-3.13-4.el9.noarch                     perl-libs-4:5.32.1-481.el9.x86_64
  perl-mro-1.23-481.el9.x86_64                perl-overload-1.31-481.el9.noarch             perl-overloading-0.02-481.el9.noarch              perl-parent-1:0.238-460.el9.noarch 
  perl-podlators-1:4.14-460.el9.noarch        perl-subs-1.03-481.el9.noarch                 perl-vars-1.05-481.el9.noarch                     policycoreutils-python-utils-3.6-2.1.el9.noarch   
  protobuf-lite-3.14.0-13.el9.x86_64          python3-audit-3.1.5-1.0.1.el9.x86_64          python3-distro-1.5.0-7.el9.noarch                 python3-libsemanage-3.6-1.el9.x86_64  
  python3-policycoreutils-3.6-2.1.el9.noarch  python3-setools-4.4.4-1.el9.x86_64            python3-setuptools-53.0.0-13.el9.noarch    

Complete!
```

#### 1.2. Start service by `sudo systemctl start mysqld`  

#### 1.3. Enable *MySQL*: `sudo systemctl enable --now mysqld`  

```bash
Created symlink /etc/systemd/system/multi-user.target.wants/mysqld.service → /usr/lib/systemd/system/mysqld.service.
```

#### 1.4. Verify by `sudo systemctl status mysqld`  

```bash
● mysqld.service - MySQL 8.0 database server
     Loaded: loaded (/usr/lib/systemd/system/mysqld.service; enabled; preset: disabled)
     Active: active (running) since Tue 2025-03-18 19:11:32 UTC; 1min 16s ago
   Main PID: 17096 (mysqld)
     Status: "Server is operational"
      Tasks: 37 (limit: 5759)
     Memory: 415.0M
        CPU: 6.018s
     CGroup: /system.slice/mysqld.service
             └─17096 /usr/libexec/mysqld --basedir=/usr

Mar 18 19:11:15 dbserver systemd[1]: Starting MySQL 8.0 database server...
Mar 18 19:11:15 dbserver mysql-prepare-db-dir[17024]: Initializing MySQL database
Mar 18 19:11:32 dbserver systemd[1]: Started MySQL 8.0 database server.
```

#### 2. Securely configure *MySQL*: `sudo mysql_secure_installation`

Output:  

```bash
Securing the MySQL server deployment.

Connecting to MySQL using a blank password.

VALIDATE PASSWORD COMPONENT can be used to test passwords
and improve security. It checks the strength of password
and allows the users to set only those passwords which are
secure enough. Would you like to setup VALIDATE PASSWORD component?

Press y|Y for Yes, any other key for No:
Please set the password for root here.

New password:
Re-enter new password:

By default, a MySQL installation has an anonymous user,
allowing anyone to log into MySQL without having to have
a user account created for them. This is intended only for
testing, and to make the installation go a bit smoother.
You should remove them before moving into a production
environment.

Remove anonymous users? (Press y|Y for Yes, any other key for No) : y
Success.

Normally, root should only be allowed to connect from
'localhost'. This ensures that someone cannot guess at
the root password from the network.

Disallow root login remotely? (Press y|Y for Yes, any other key for No) : y
Success.

By default, MySQL comes with a database named 'test' that
anyone can access. This is also intended only for testing,
and should be removed before moving into a production
environment.

Remove test database and access to it? (Press y|Y for Yes, any other key for No) : y
 - Dropping test database...
Success.

 - Removing privileges on test database...
Success.

Reloading the privilege tables will ensure that all changes
made so far will take effect immediately.

Reload privilege tables now? (Press y|Y for Yes, any other key for No) : y
Success.

All done!
```

#### 3.1. Enter into *MySQL* environment by `mysql -u root -p`  

#### 3.2. Create database for the *WordPress*  

```sql
CREATE DATABASE wordpress;
```

To verify creation: `SHOW DATABASES;`.  

```sql
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| wordpress          |
+--------------------+
```

#### 3.3. Create remote root user  

> `<password>` is a placeholder for an actual password to be not exposed.  

```sql
CREATE USER 'wp_user'@'%' IDENTIFIED BY '<password>';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'%';
FLUSH PRIVILEGES;
EXIT;
```

It may be required to grant options explicitly, if some basic commands do not work properly:  

```sql
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER ON wordpress.* TO 'wp_user'@'%';
```

---

## Task 3: Install the WordPress

Now install your WordPress application on two separate machines — one for the web server (which should not have a database) and solely another for the database only, ensuring they can communicate with each other.  

### 3.1. Web server

#### 1. Download, install, unzip *WordPress*  

```bash
cd /var/www/html
sudo curl -O https://wordpress.org/latest.tar.gz
sudo tar -xvzf latest.tar.gz
sudo mv wordpress/* .
sudo rmdir wordpress
sudo rm -f latest.tar.gz
```

#### 2. Set *Apache* permissions  

```bash
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html
```

#### 3. Create *config* file for webserver  

```bash
sudo nano /etc/httpd/conf.d/wordpress.conf
```

Add the following directives inside it:  

```xml
<VirtualHost *:80>
    ServerName wordpress.com
    DocumentRoot /var/www/html

    <Directory /var/www/html>
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog /var/log/httpd/wordpress_error.log
    CustomLog /var/log/httpd/wordpress_access.log combined
</VirtualHost>
```

Add a global *ServerName* directive in Apache’s main configuration file ( `sudo nano /etc/httpd/conf/httpd.conf`):  
`ServerName wordpress.com:80`.  

#### 4. Restart *Apache*

> Check for any errors / warnings: `sudo apachectl configtest`.  

`sudo systemctl restart httpd`  
`sudo systemctl status httpd`  

```bash
● httpd.service - The Apache HTTP Server
     Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; preset: disabled)
    Drop-In: /usr/lib/systemd/system/httpd.service.d
             └─php-fpm.conf
     Active: active (running) since Tue 2025-03-18 20:12:20 UTC; 8s ago
       Docs: man:httpd.service(8)
   Main PID: 4659 (httpd)
     Status: "Started, listening on: port 80"
      Tasks: 177 (limit: 12200)
     Memory: 20.6M
        CPU: 111ms
     CGroup: /system.slice/httpd.service
             ├─4659 /usr/sbin/httpd -DFOREGROUND
             ├─4660 /usr/sbin/httpd -DFOREGROUND
             ├─4661 /usr/sbin/httpd -DFOREGROUND
             ├─4662 /usr/sbin/httpd -DFOREGROUND
             └─4663 /usr/sbin/httpd -DFOREGROUND

Mar 18 20:12:20 webserver systemd[1]: Starting The Apache HTTP Server...
Mar 18 20:12:20 webserver systemd[1]: Started The Apache HTTP Server.
Mar 18 20:12:20 webserver httpd[4659]: Server configured, listening on: port 80
```

### 3.2. DB server

#### 1. Configure *MySQL* file to allow remote connections

`sudo nano /etc/my.cnf.d/mysql-server.cnf`, then change (or add) **binding IP**: `bind-address = 0.0.0.0`.  

> To verify: `sudo ls /etc/my.cnf* | sudo grep -r "bind-address" /etc/`, the output should be `/etc/my.cnf.d/mysql-server.cnf:bind-address = 0.0.0.0`.  

Apply changes be restarting: `sudo systemctl restart mysqld`.  

#### 2. Configure firewall  

```bash
sudo firewall-cmd --permanent --add-service=mysql
sudo firewall-cmd --reload
```

Check by running `sudo firewall-cmd --list-all`. If it set up properly, the output must contain `ports: 3306/tcp`.  

##### Troubleshooting

If it does not work as expected, open port `3306` manually: `sudo firewall-cmd --permanent --add-port=3306/tcp`.  
Verify again before proceed.  

You can check the *listening* state of the port 3306 by `ss -tunlp | grep 3306`.  

### 3.3. Enabling communication

#### 1. Ensure that two VMs are in the same local network

> Check this on the *Vagrantfile*.  

| VM | IP |
| --- | --- |
| webserver | 192.168.33.10 |
| dbserver | 192.168.33.11 |

#### 2. Configure *Apache* on the webserver  

```bash
cd /var/www/html
sudo cp wp-config-sample.php wp-config.php
sudo nano wp-config.php
```

Change the corresponding lines to mach the following:  

```bash
define( 'DB_NAME', 'wordpress' );
define( 'DB_USER', 'wp_user' );
define( 'DB_PASSWORD', '<password>' );
define( 'DB_HOST', '192.168.33.11' );
```

#### 3. Go to this page from the browser on *webserver*

`http://localhost`  

##### *lynx* browser

```bash
sudo dnf install lynx -y
lynx --version
```

> In case of *database error* on connection, run `sudo setenforce 0`.  

#### 4. Complete installation, following the *WordPress* installation wizard

1. Go to the site by `lynx http://localhost`.  
2. Chose language, check up the DB configuration, run the installation if everything is OK.  
3. Set up admin account.  
4. Log in after installation.  

### 3.4. Verifying

#### 0. Enable both VMs and check the network connectivuty

`ping -c 4 192.168.33.x` (*x* depends on which machine trying to ping).  

Output of `ping` from *webserver* to *dbserver*:  

```bash
PING 192.168.33.11 (192.168.33.11) 56(84) bytes of data.
64 bytes from 192.168.33.11: icmp_seq=1 ttl=64 time=2.77 ms
64 bytes from 192.168.33.11: icmp_seq=2 ttl=64 time=1.22 ms
64 bytes from 192.168.33.11: icmp_seq=3 ttl=64 time=1.44 ms
64 bytes from 192.168.33.11: icmp_seq=4 ttl=64 time=1.42 ms

--- 192.168.33.11 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3006ms
rtt min/avg/max/mdev = 1.223/1.712/2.766/0.614 ms
```

Output of `ping` from *dbserver* to *webserver*:  

```bash
PING 192.168.33.10 (192.168.33.10) 56(84) bytes of data.
64 bytes from 192.168.33.10: icmp_seq=1 ttl=64 time=1.78 ms
64 bytes from 192.168.33.10: icmp_seq=2 ttl=64 time=1.80 ms
64 bytes from 192.168.33.10: icmp_seq=3 ttl=64 time=1.24 ms
64 bytes from 192.168.33.10: icmp_seq=4 ttl=64 time=1.16 ms

--- 192.168.33.10 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3005ms
rtt min/avg/max/mdev = 1.164/1.496/1.800/0.294 ms
```

#### 1. Check port accessibility

Verify that port 3306 (MySQL) is open and accessible from *webserver*: `nc -zv 192.168.33.11 3306`.  

```bash
Ncat: Version 7.92 ( https://nmap.org/ncat )
Ncat: Connected to 192.168.33.11:3306.
Ncat: 0 bytes sent, 0 bytes received in 0.04 seconds.
```

#### 2. Access *database* from *webserver* machine

> To run this, *MySQL* installation on the *webserver* needed.  

`mysql -u wp_user -p -h 192.168.33.11 wordpress`  

```bash
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 9
Server version: 8.0.41 Source distribution

Copyright (c) 2000, 2025, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> 
```

Test: `SHOW DATABASES;`.  

```sql
+--------------------+
| Database           |
+--------------------+
| information_schema |
| performance_schema |
| wordpress          |
+--------------------+
3 rows in set (0.47 sec)
```

#### 3. Access *WordPress* from browser

`lynx http://localhost`, navigate to some link to check functionality.  

[Sample page](https://drive.google.com/file/d/1OT4oB5XYuYpkktnlBdeDFG4TtMkJDI3G/view?usp=drive_link)

---

## Results

All [screenshots](https://drive.google.com/drive/folders/1mOzFSNN4IJh_lr6taQpdt2uJLj8vJYnr?usp=drive_link) and **crucial steps**:  

- [Apache](https://drive.google.com/file/d/1nGa2g-z0wwuDvi-TbtQ7zRp7hLpXPO8s/view?usp=drive_link) and [Softserve](https://drive.google.com/file/d/1mgcDvICDb1SUSk4OTzBiq3cR17e3qjMz/view?usp=drive_link) pages on the web server that were configured on the **KillerCoda**;  
- the working [WordPress](https://drive.google.com/file/d/105sQEftBUA1aiOAp8mLtsnKrzw576jA6/view?usp=drive_link) site;  
- the *separate machines* configured for the **web server** and the **database**:  
  - [Vagrantfile](https://github.com/nromanen/devops_2025/blob/main/kateryna_kravchuk/task_12/vms/Vagrantfile);  
  - running into [Virtual Box](https://drive.google.com/file/d/1UH_3n4zojgG0q7d5QaKed47K0FJ_E05U/view?usp=drive_link);  
  - running into [Vagrant](https://drive.google.com/file/d/1kS0gejtAOZWQGKmjKy1YRckL3afcwVDD/view?usp=drive_link), check by `vagrant global-status`:  

```sh
id       name    provider   state    directory
---------------------------------------------------------------------------------------------------------
5ef0e18  web     virtualbox running  F:/devopsv/clone_nromanen/devops_2025/kateryna_kravchuk/task_12/vms 
9aafa6c  db      virtualbox running  F:/devopsv/clone_nromanen/devops_2025/kateryna_kravchuk/task_12/vms 
```
