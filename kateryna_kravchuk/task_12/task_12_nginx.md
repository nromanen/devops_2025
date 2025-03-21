# Task 12: Task on Nginx

> Done by [@Lians-coder](https://github.com/Lians-coder) (Kateryna Kravchuk)

## Preparation

> I desided to do almost all subtasks with *Vagrant*.  

Go to the desired directory and run `vagrant init`.  
The next steps from **part A** will add some commands to the *Vagrantfile*.  

---

## Part A: Vagrantfile

### 1. Install the Nginx server

#### 1. Common settings

The following settings should be applied on all VMs.  
The first two rows adjust *SELinux policies* to allow Nginx to connect to the backend services permanently.  
Here are also commands to install **Node.js** for the *app.js* that will be running, and **NPM** to install dependencies from *package.json*.  

```ruby
  config.vm.provision "shell", name: "common", inline: <<-SHELL
    # Disable SELinux permanently
    sudo setenforce 0
    sudo sed -i 's/^SELINUX=enforcing$/SELINUX=disabled/' /

    # Install Nginx
    sudo dnf install -y epel-release
    sudo dnf install -y nginx
    sudo systemctl enable --now nginx

    # Install Node.js
    sudo dnf install -y nodejs npm
  SHELL
```

#### 2. Balancer firewall

Set up firewall configuration before proceeding to the specific Nginx configuration.  

```ruby
    # Enables HTTP traffic
    bal.vm.provision "shell", inline: <<-SHELL
      sudo systemctl enable --now firewalld
      sudo firewall-cmd --permanent --add-service=http
      sudo firewall-cmd --reload
    SHELL
```

---

### 2. Start two additional servers for balancing

```ruby
  # FOR EACH BACKUP <N>
  config.vm.define "b<n>" do |b<n>|
    b<n>.vm.hostname = "backup"
    b<n>.vm.network "private_network", ip: "192.168.x.x"
    b<n>.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 1
    end
    app_setup(b<n>, "app<n>.js")
  end
```

**Legend**: *n* - number of server, *x* - some part of IP, *pppp* - port number.  

| VM | IP |
| --- | --- |
| balancer | `192.168.33.10` |
| backup1 | `192.168.33.11` |
| backup2 | `192.168.33.12` |
| backup3 | `192.168.33.13` |

---

### 3. Configure *app*

#### 1. `app.js` files

Make `app<n>.js` file for each backup server in the `files` directory (should be in the same one, where is *Vagrantfile* itself):  

```js
const express = require("express");
const app = express();

app.get("/", (req, res) => {
    res.send("I am an endpoint\n");
});

app.listen(<pppp>, () => {
    console.log("App <n> is running on http://localhost:<pppp>\n");
});
```

> *Legend* is the same.  

#### 2. Make `package.json` file in that directory  

```json
{
    "dependencies": {
        "body-parser": "^1.20.2",
        "cors": "^2.8.5",
        "express": "^4.18.2"
    }
}
```

#### 3. Configure each backup server to run an app

```ruby
  # Configure each app server
  def app_setup(vm, app_file)
    vm.vm.provision "file", source: "files/package.json", destination: "/home/vagrant/package.json"
    vm.vm.provision "file", source: "files/#{app_file}", destination: "/home/vagrant/app.js"
    vm.vm.provision "shell", inline: <<-SHELL
      cd /home/vagrant
      npm install
    SHELL
    vm.vm.provision "shell", inline: <<-SHELL, run: "always"
      nohup node app.js > app.log 2>&1 & 
    SHELL
  end
```

##### Notes on some commands

| Part | Explanation |
| --- | --- |
| `nohup` | Keeps the process running even after logging out. |
| `node app.js` | Starts the Node.js application. |
| `>` | Redirects standard output (`stdout`) to a file. |
| `app.log` | The file where logs are stored. |
| `2>&1` | Redirects error output (`stderr ) to the same file (`app.log). |
| `&` | Runs the process in the background. |

#### 4. Open ports

```ruby
    # Apply firewall rules
    vm.vm.provision "shell", inline: <<-SHELL
      sudo systemctl enable --now firewalld
      sudo firewall-cmd --permanent --add-port=3000/tcp
      sudo firewall-cmd --permanent --add-port=3001/tcp
      sudo firewall-cmd --permanent --add-port=3002/tcp
      sudo firewall-cmd --reload
    SHELL
```

---

### 4. Set up load balancing (upstream) with the Nginx web server

#### 1. Make a *Nginx* configuration file  

```conf
events { }

http {
    upstream backendserver {
        server 192.168.33.11:3000;
        server 192.168.33.12:3001;
        server 192.168.33.13:3002;
    }
    server {
        listen 80;
        
        location / {
            proxy_pass http://backendserver/;
            add_header X-Backend-Server $upstream_addr;
        }
    }
}
```

##### Notes on the `nginx.conf`

| Command | Purpose | Notes |
| --- | --- | --- |
| `upstream backendserver` | Defines a **load balancing group** | Lists three *backend servers*, each running on a different `<IP>:<port>`. |
| `server` | Defines a virtuall host | Make *Nginx* listen on port `80` (HTTP) for incoming requests. |
| `location /` | Handles requests to the root (/) path. | |
| `X-Backend-Server` | custom headers in Nginx to show which backend is used. | |

#### 2. Add the following to the *balancer* VM  

```ruby
    # Nginx config
    bal.vm.provision "file", source: "files/nginx.conf", destination: "/home/vagrant/nginx.conf"
    bal.vm.provision "shell", inline: <<-SHELL
      sudo mv /home/vagrant/nginx.conf /etc/nginx/nginx.conf
      sudo restorecon -v /etc/nginx/nginx.conf
      sudo nginx -t && sudo systemctl restart nginx
      sudo systemctl status nginx
    SHELL
```

> *vagrant* user does not have the required pernission to directly modify `/etc/` directory on provision, that's why the temporare folder `/home/vagrant/nginx.conf` needed.  

---

### Complete *Vagrantfile*

> The order of running VMs up is the key: the Nginx load *balancer* (on the **bal** server) will be configured to proxy requests to the *backend* servers (**backup1**, **backup2**, **backup3**), which are running on specific ports. If the backend servers are not running when the balancer is started, the Nginx configuration will fail because there will be no services listening on those backend IPs and ports.

[Vagrantfile](https://github.com/nromanen/devops_2025/blob/main/kateryna_kravchuk/task_12/vms_lb/Vagrantfile)  

---

## Part B: Provision

### 1. Check up for any errors by `vagrant validate`

```bash
Vagrantfile validated successfully.
```

> Note that successful validation **does not mean** any errors wouldn't appear during actual provision process.  

### 2. Check the status of VMs by `vagrant status`

```bash
bal                       not created (virtualbox)
b1                        not created (virtualbox)
b2                        not created (virtualbox)
b3                        not created (virtualbox)
```

### 3. Run all VMs by `vagrant up`  

In case of any modification made in the *Vagrantfile*, use `vagrant provision` instead.  
For the debugging purposes, it may be useful to run one VM at once by `vagrant up <vm_name>`, and then connect only to it: `vagrant ssh <vm_name>`.  

```bash
```bash
Bringing machine 'b1' up with 'virtualbox' provider...
Bringing machine 'b2' up with 'virtualbox' provider...
Bringing machine 'b3' up with 'virtualbox' provider...
Bringing machine 'bal' up with 'virtualbox' provider...
```

#### Output for *Backup* servers

> It is the same for *b2* and *b3* servers, so here are only for the first one (*b1*).  

```bash
==> b1: Importing base box 'oraclelinux/9'...
==> b1: Matching MAC address for NAT networking...
==> b1: Checking if box 'oraclelinux/9' version '9.5.649' is up to date...
==> b1: Setting the name of the VM: vms_lb_b1_1742554807296_15282
==> b1: Clearing any previously set network interfaces...
==> b1: Preparing network interfaces based on configuration...
    b1: Adapter 1: nat
    b1: Adapter 2: hostonly
==> b1: Forwarding ports...
    b1: 22 (guest) => 2222 (host) (adapter 1)
==> b1: Running 'pre-boot' VM customizations...
==> b1: Booting VM...
==> b1: Waiting for machine to boot. This may take a few minutes...
    b1: SSH address: 127.0.0.1:2222
    b1: SSH username: vagrant
    b1: SSH auth method: private key
    b1: 
    b1: Vagrant insecure key detected. Vagrant will automatically replace
    b1: this with a newly generated keypair for better security.
    b1: 
    b1: Inserting generated public key within guest...
    b1: Removing insecure key from the guest if it's present...
    b1: Key inserted! Disconnecting and reconnecting using new SSH key...
==> b1: Machine booted and ready!
==> b1: Checking for guest additions in VM...
==> b1: Setting hostname...
==> b1: Configuring and enabling network interfaces...
==> b1: Mounting shared folders...
    b1: F:/devopsv/clone_nromanen/devops_2025/kateryna_kravchuk/task_12/vms_lb => /vagrant
==> b1: Running provisioner: common (shell)...
    b1: Running: script: common
    b1: setenforce: SELinux is disabled
    b1: Oracle Linux 9 BaseOS Latest (x86_64)           2.2 MB/s |  54 MB     00:25
    b1: Oracle Linux 9 Application Stream Packages (x86 3.0 MB/s |  52 MB     00:17
    b1: Oracle Linux 9 UEK Release 7 (x86_64)           2.8 MB/s |  59 MB     00:21
    b1: Last metadata expiration check: 0:00:17 ago on Fri 21 Mar 2025 11:03:12 AM UTC.
    b1: Dependencies resolved.
    b1: ================================================================================
    b1:  Package                  Arch    Version              Repository          Size
    b1: ================================================================================
    b1: Installing:
    b1:  oracle-epel-release-el9  x86_64  1.0-1.el9            ol9_baseos_latest   14 k
    b1: Installing dependencies:
    b1:  yum-utils                noarch  4.3.0-16.0.1.el9     ol9_baseos_latest   53 k
    b1:
    b1: Transaction Summary
    b1: ================================================================================
    b1: Install  2 Packages
    b1:
    b1: Total download size: 67 k
    b1: Installed size: 41 k
    b1: Downloading Packages:
    b1: (1/2): oracle-epel-release-el9-1.0-1.el9.x86_64  15 kB/s |  14 kB     00:00
    b1: (2/2): yum-utils-4.3.0-16.0.1.el9.noarch.rpm     47 kB/s |  53 kB     00:01
    b1: --------------------------------------------------------------------------------
    b1: Total                                            59 kB/s |  67 kB     00:01
    b1: Running transaction check
    b1: Transaction check succeeded.
    b1: Running transaction test
    b1: Transaction test succeeded.
    b1: Running transaction
    b1:   Preparing        :                                                        1/1
    b1:   Installing       : yum-utils-4.3.0-16.0.1.el9.noarch                      1/2
    b1:   Installing       : oracle-epel-release-el9-1.0-1.el9.x86_64               2/2
    b1:   Running scriptlet: oracle-epel-release-el9-1.0-1.el9.x86_64               2/2
    b1:   Verifying        : oracle-epel-release-el9-1.0-1.el9.x86_64               1/2
    b1:   Verifying        : yum-utils-4.3.0-16.0.1.el9.noarch                      2/2
    b1:
    b1: Installed:
    b1:   oracle-epel-release-el9-1.0-1.el9.x86_64   yum-utils-4.3.0-16.0.1.el9.noarch
    b1:
    b1: Complete!
    b1: Oracle Linux 9 EPEL Packages for Development (x 1.6 MB/s |  29 MB     00:18
    b1: Last metadata expiration check: 0:00:17 ago on Fri 21 Mar 2025 11:04:00 AM UTC.
    b1: Dependencies resolved.
    b1: ================================================================================
    b1:  Package              Arch     Version                Repository           Size
    b1: ================================================================================
    b1: Installing:
    b1:  nginx                x86_64   2:1.20.1-20.0.1.el9    ol9_appstream        48 k
    b1: Installing dependencies:
    b1:  nginx-core           x86_64   2:1.20.1-20.0.1.el9    ol9_appstream       588 k
    b1:  nginx-filesystem     noarch   2:1.20.1-20.0.1.el9    ol9_appstream       8.5 k
    b1:  oracle-logos-httpd   noarch   90.2-1.0.4.el9         ol9_baseos_latest    37 k
    b1:
    b1: Transaction Summary
    b1: ================================================================================
    b1: Install  4 Packages
    b1:
    b1: Total download size: 682 k
    b1: Installed size: 1.8 M
    b1: Downloading Packages:
    b1: (1/4): oracle-logos-httpd-90.2-1.0.4.el9.noarch  32 kB/s |  37 kB     00:01
    b1: (2/4): nginx-1.20.1-20.0.1.el9.x86_64.rpm        42 kB/s |  48 kB     00:01
    b1: (3/4): nginx-filesystem-1.20.1-20.0.1.el9.noarc  43 kB/s | 8.5 kB     00:00
    b1: (4/4): nginx-core-1.20.1-20.0.1.el9.x86_64.rpm  296 kB/s | 588 kB     00:01
    b1: --------------------------------------------------------------------------------
    b1: Total                                           341 kB/s | 682 kB     00:01
    b1: Running transaction check
    b1: Transaction check succeeded.
    b1: Running transaction test
    b1: Transaction test succeeded.
    b1: Running transaction
    b1:   Preparing        :                                                        1/1
    b1:   Running scriptlet: nginx-filesystem-2:1.20.1-20.0.1.el9.noarch            1/4
    b1:   Installing       : nginx-filesystem-2:1.20.1-20.0.1.el9.noarch            1/4
    b1:   Installing       : nginx-core-2:1.20.1-20.0.1.el9.x86_64                  2/4
    b1:   Installing       : oracle-logos-httpd-90.2-1.0.4.el9.noarch               3/4
    b1:   Installing       : nginx-2:1.20.1-20.0.1.el9.x86_64                       4/4
    b1:   Running scriptlet: nginx-2:1.20.1-20.0.1.el9.x86_64                       4/4
    b1:   Verifying        : oracle-logos-httpd-90.2-1.0.4.el9.noarch               1/4
    b1:   Verifying        : nginx-2:1.20.1-20.0.1.el9.x86_64                       2/4
    b1:   Verifying        : nginx-core-2:1.20.1-20.0.1.el9.x86_64                  3/4
    b1:   Verifying        : nginx-filesystem-2:1.20.1-20.0.1.el9.noarch            4/4
    b1:
    b1: Installed:
    b1:   nginx-2:1.20.1-20.0.1.el9.x86_64
    b1:   nginx-core-2:1.20.1-20.0.1.el9.x86_64
    b1:   nginx-filesystem-2:1.20.1-20.0.1.el9.noarch
    b1:   oracle-logos-httpd-90.2-1.0.4.el9.noarch
    b1:
    b1: Complete!
    b1: Created symlink /etc/systemd/system/multi-user.target.wants/nginx.service → /usr/lib/systemd/system/nginx.service.
    b1: Last metadata expiration check: 0:00:34 ago on Fri 21 Mar 2025 11:04:00 AM UTC.
    b1: Dependencies resolved.
    b1: ================================================================================
    b1:  Package           Arch    Version                         Repository      Size
    b1: ================================================================================
    b1: Installing:
    b1:  nodejs            x86_64  1:16.20.2-8.0.1.el9_4           ol9_appstream  122 k
    b1:  npm               x86_64  1:8.19.4-1.16.20.2.8.0.1.el9_4  ol9_appstream  3.4 M
    b1: Installing dependencies:
    b1:  nodejs-libs       x86_64  1:16.20.2-8.0.1.el9_4           ol9_appstream   14 M
    b1: Installing weak dependencies:
    b1:  nodejs-docs       noarch  1:16.20.2-8.0.1.el9_4           ol9_appstream  7.8 M
    b1:  nodejs-full-i18n  x86_64  1:16.20.2-8.0.1.el9_4           ol9_appstream  8.2 M
    b1: 
    b1: Transaction Summary
    b1: ================================================================================
    b1: Install  5 Packages
    b1:
    b1: Total download size: 34 M
    b1: Installed size: 168 M
    b1: Downloading Packages:
    b1: (1/5): nodejs-16.20.2-8.0.1.el9_4.x86_64.rpm     99 kB/s | 122 kB     00:01
    b1: (2/5): nodejs-full-i18n-16.20.2-8.0.1.el9_4.x86 708 kB/s | 8.2 MB     00:11
    b1: (3/5): npm-8.19.4-1.16.20.2.8.0.1.el9_4.x86_64. 1.8 MB/s | 3.4 MB     00:01
    b1: (4/5): nodejs-docs-16.20.2-8.0.1.el9_4.noarch.r 532 kB/s | 7.8 MB     00:14
    b1: (5/5): nodejs-libs-16.20.2-8.0.1.el9_4.x86_64.r 872 kB/s |  14 MB     00:17
    b1: --------------------------------------------------------------------------------
    b1: Total                                           1.9 MB/s |  34 MB     00:18
    b1: Running transaction check
    b1: Transaction check succeeded.
    b1: Running transaction test
    b1: Transaction test succeeded.
    b1: Running transaction
    b1:   Running scriptlet: npm-1:8.19.4-1.16.20.2.8.0.1.el9_4.x86_64              1/1
    b1:   Preparing        :                                                        1/1
    b1:   Installing       : nodejs-libs-1:16.20.2-8.0.1.el9_4.x86_64               1/5
    b1:   Installing       : nodejs-docs-1:16.20.2-8.0.1.el9_4.noarch               2/5
    b1:   Installing       : nodejs-full-i18n-1:16.20.2-8.0.1.el9_4.x86_64          3/5
    b1:   Installing       : npm-1:8.19.4-1.16.20.2.8.0.1.el9_4.x86_64              4/5
    b1:   Installing       : nodejs-1:16.20.2-8.0.1.el9_4.x86_64                    5/5
    b1:   Running scriptlet: nodejs-1:16.20.2-8.0.1.el9_4.x86_64                    5/5
    b1:   Verifying        : nodejs-1:16.20.2-8.0.1.el9_4.x86_64                    1/5
    b1:   Verifying        : nodejs-docs-1:16.20.2-8.0.1.el9_4.noarch               2/5
    b1:   Verifying        : nodejs-full-i18n-1:16.20.2-8.0.1.el9_4.x86_64          3/5
    b1:   Verifying        : nodejs-libs-1:16.20.2-8.0.1.el9_4.x86_64               4/5
    b1:   Verifying        : npm-1:8.19.4-1.16.20.2.8.0.1.el9_4.x86_64              5/5
    b1:
    b1: Installed:
    b1:   nodejs-1:16.20.2-8.0.1.el9_4.x86_64
    b1:   nodejs-docs-1:16.20.2-8.0.1.el9_4.noarch
    b1:   nodejs-full-i18n-1:16.20.2-8.0.1.el9_4.x86_64
    b1:   nodejs-libs-1:16.20.2-8.0.1.el9_4.x86_64
    b1:   npm-1:8.19.4-1.16.20.2.8.0.1.el9_4.x86_64
    b1:
    b1: Complete!
==> b1: Running provisioner: file...
    b1: files/package.json => /home/vagrant/package.json
==> b1: Running provisioner: file...
    b1: files/app1.js => /home/vagrant/app.js
==> b1: Running provisioner: shell...
    b1: Running: inline script
    b1: 
    b1: added 71 packages, and audited 72 packages in 9s
    b1:
    b1: 14 packages are looking for funding
    b1:   run `npm fund` for details
    b1:
    b1: found 0 vulnerabilities
    b1: npm notice
    b1: npm notice New major version of npm available! 8.19.4 -> 11.2.0
    b1: npm notice Changelog: <https://github.com/npm/cli/releases/tag/v11.2.0>
    b1: npm notice Run `npm install -g npm@11.2.0` to update!
    b1: npm notice
==> b1: Running provisioner: shell...
    b1: Running: inline script
    b1: Created symlink /etc/systemd/system/dbus-org.fedoraproject.FirewallD1.service → /usr/lib/systemd/system/firewalld.service.
    b1: Created symlink /etc/systemd/system/multi-user.target.wants/firewalld.service → /usr/lib/systemd/system/firewalld.service.
    b1: success
    b1: success
    b1: success
    b1: success
```

#### Output for *Balancer* VM

```bash
==> bal: Importing base box 'oraclelinux/9'...
==> bal: Matching MAC address for NAT networking...
==> bal: Checking if box 'oraclelinux/9' version '9.5.649' is up to date...
==> bal: Setting the name of the VM: vms_lb_bal_1742556184221_18673
==> bal: Fixed port collision for 22 => 2222. Now on port 2202.
==> bal: Clearing any previously set network interfaces...
==> bal: Preparing network interfaces based on configuration...
    bal: Adapter 1: nat
    bal: Adapter 2: hostonly
==> bal: Forwarding ports...
    bal: 22 (guest) => 2202 (host) (adapter 1)
==> bal: Running 'pre-boot' VM customizations...
==> bal: Booting VM...
==> bal: Waiting for machine to boot. This may take a few minutes...
    bal: SSH address: 127.0.0.1:2202
    bal: SSH username: vagrant
    bal: SSH auth method: private key
    bal: 
    bal: Vagrant insecure key detected. Vagrant will automatically replace
    bal: this with a newly generated keypair for better security.
    bal: 
    bal: Inserting generated public key within guest...
    bal: Removing insecure key from the guest if it's present...
    bal: Key inserted! Disconnecting and reconnecting using new SSH key...
==> bal: Machine booted and ready!
==> bal: Checking for guest additions in VM...
==> bal: Setting hostname...
==> bal: Configuring and enabling network interfaces...
==> bal: Mounting shared folders...
    bal: F:/devopsv/clone_nromanen/devops_2025/kateryna_kravchuk/task_12/vms_lb => /vagrant
==> bal: Running provisioner: common (shell)...
    bal: Running: script: common
    bal: setenforce: SELinux is disabled
    bal: Oracle Linux 9 BaseOS Latest (x86_64)           2.9 MB/s |  54 MB     00:18
    bal: Oracle Linux 9 Application Stream Packages (x86 3.0 MB/s |  52 MB     00:17
    bal: Oracle Linux 9 UEK Release 7 (x86_64)           3.1 MB/s |  59 MB     00:18
    bal: Last metadata expiration check: 0:00:17 ago on Fri 21 Mar 2025 11:26:08 AM UTC.
    bal: Dependencies resolved.
    bal: ================================================================================
    bal:  Package                  Arch    Version              Repository          Size
    bal: ================================================================================
    bal: Installing:
    bal:  oracle-epel-release-el9  x86_64  1.0-1.el9            ol9_baseos_latest   14 k
    bal: Installing dependencies:
    bal:  yum-utils                noarch  4.3.0-16.0.1.el9     ol9_baseos_latest   53 k
    bal:
    bal: Transaction Summary
    bal: ================================================================================
    bal: Install  2 Packages
    bal:
    bal: Total download size: 67 k
    bal: Installed size: 41 k
    bal: Downloading Packages:
    bal: (1/2): oracle-epel-release-el9-1.0-1.el9.x86_64  21 kB/s |  14 kB     00:00
    bal: (2/2): yum-utils-4.3.0-16.0.1.el9.noarch.rpm     46 kB/s |  53 kB     00:01
    bal: --------------------------------------------------------------------------------
    bal: Total                                            57 kB/s |  67 kB     00:01
    bal: Running transaction check
    bal: Transaction check succeeded.
    bal: Running transaction test
    bal: Transaction test succeeded.
    bal: Running transaction
    bal:   Preparing        :                                                        1/1
    bal:   Installing       : yum-utils-4.3.0-16.0.1.el9.noarch                      1/2
    bal:   Installing       : oracle-epel-release-el9-1.0-1.el9.x86_64               2/2
    bal:   Running scriptlet: oracle-epel-release-el9-1.0-1.el9.x86_64               2/2
    bal:   Verifying        : oracle-epel-release-el9-1.0-1.el9.x86_64               1/2
    bal:   Verifying        : yum-utils-4.3.0-16.0.1.el9.noarch                      2/2
    bal:
    bal: Installed:
    bal:   oracle-epel-release-el9-1.0-1.el9.x86_64   yum-utils-4.3.0-16.0.1.el9.noarch
    bal:
    bal: Complete!
    bal: Oracle Linux 9 EPEL Packages for Development (x 1.9 MB/s |  29 MB     00:15
    bal: Last metadata expiration check: 0:00:19 ago on Fri 21 Mar 2025 11:26:47 AM UTC.
    bal: Dependencies resolved.
    bal: ================================================================================
    bal:  Package              Arch     Version                Repository           Size
    bal: ================================================================================
    bal: Installing:
    bal:  nginx                x86_64   2:1.20.1-20.0.1.el9    ol9_appstream        48 k
    bal: Installing dependencies:
    bal:  nginx-core           x86_64   2:1.20.1-20.0.1.el9    ol9_appstream       588 k
    bal:  nginx-filesystem     noarch   2:1.20.1-20.0.1.el9    ol9_appstream       8.5 k
    bal:  oracle-logos-httpd   noarch   90.2-1.0.4.el9         ol9_baseos_latest    37 k
    bal:
    bal: Transaction Summary
    bal: ================================================================================
    bal: Install  4 Packages
    bal: 
    bal: Total download size: 682 k
    bal: Installed size: 1.8 M
    bal: Downloading Packages:
    bal: (1/4): oracle-logos-httpd-90.2-1.0.4.el9.noarch  37 kB/s |  37 kB     00:01
    bal: (2/4): nginx-1.20.1-20.0.1.el9.x86_64.rpm        48 kB/s |  48 kB     00:01
    bal: (3/4): nginx-filesystem-1.20.1-20.0.1.el9.noarc  41 kB/s | 8.5 kB     00:00
    bal: (4/4): nginx-core-1.20.1-20.0.1.el9.x86_64.rpm  300 kB/s | 588 kB     00:01
    bal: --------------------------------------------------------------------------------
    bal: Total                                           346 kB/s | 682 kB     00:01
    bal: Running transaction check
    bal: Transaction check succeeded.
    bal: Running transaction test
    bal: Transaction test succeeded.
    bal: Running transaction
    bal:   Preparing        :                                                        1/1
    bal:   Running scriptlet: nginx-filesystem-2:1.20.1-20.0.1.el9.noarch            1/4
    bal:   Installing       : nginx-filesystem-2:1.20.1-20.0.1.el9.noarch            1/4
    bal:   Installing       : nginx-core-2:1.20.1-20.0.1.el9.x86_64                  2/4
    bal:   Installing       : oracle-logos-httpd-90.2-1.0.4.el9.noarch               3/4
    bal:   Installing       : nginx-2:1.20.1-20.0.1.el9.x86_64                       4/4
    bal:   Running scriptlet: nginx-2:1.20.1-20.0.1.el9.x86_64                       4/4
    bal:   Verifying        : oracle-logos-httpd-90.2-1.0.4.el9.noarch               1/4
    bal:   Verifying        : nginx-2:1.20.1-20.0.1.el9.x86_64                       2/4
    bal:   Verifying        : nginx-core-2:1.20.1-20.0.1.el9.x86_64                  3/4
    bal:   Verifying        : nginx-filesystem-2:1.20.1-20.0.1.el9.noarch            4/4
    bal:
    bal: Installed:
    bal:   nginx-2:1.20.1-20.0.1.el9.x86_64
    bal:   nginx-core-2:1.20.1-20.0.1.el9.x86_64
    bal:   nginx-filesystem-2:1.20.1-20.0.1.el9.noarch
    bal:   oracle-logos-httpd-90.2-1.0.4.el9.noarch
    bal:
    bal: Complete!
    bal: Created symlink /etc/systemd/system/multi-user.target.wants/nginx.service → /usr/lib/systemd/system/nginx.service.
    bal: Last metadata expiration check: 0:00:36 ago on Fri 21 Mar 2025 11:26:47 AM UTC.
    bal: Dependencies resolved.
    bal: ================================================================================
    bal:  Package           Arch    Version                         Repository      Size
    bal: ================================================================================
    bal: Installing:
    bal:  nodejs            x86_64  1:16.20.2-8.0.1.el9_4           ol9_appstream  122 k
    bal:  npm               x86_64  1:8.19.4-1.16.20.2.8.0.1.el9_4  ol9_appstream  3.4 M
    bal: Installing dependencies:
    bal:  nodejs-libs       x86_64  1:16.20.2-8.0.1.el9_4           ol9_appstream   14 M
    bal: Installing weak dependencies:
    bal:  nodejs-docs       noarch  1:16.20.2-8.0.1.el9_4           ol9_appstream  7.8 M
    bal:  nodejs-full-i18n  x86_64  1:16.20.2-8.0.1.el9_4           ol9_appstream  8.2 M
    bal:
    bal: Transaction Summary
    bal: ================================================================================
    bal: Install  5 Packages
    bal:
    bal: Total download size: 34 M
    bal: Installed size: 168 M
    bal: Downloading Packages:
    bal: (1/5): nodejs-16.20.2-8.0.1.el9_4.x86_64.rpm    159 kB/s | 122 kB     00:00
    bal: (2/5): nodejs-docs-16.20.2-8.0.1.el9_4.noarch.r 714 kB/s | 7.8 MB     00:11
    bal: (3/5): npm-8.19.4-1.16.20.2.8.0.1.el9_4.x86_64. 1.0 MB/s | 3.4 MB     00:03
    bal: (4/5): nodejs-full-i18n-16.20.2-8.0.1.el9_4.x86 509 kB/s | 8.2 MB     00:16
    bal: (5/5): nodejs-libs-16.20.2-8.0.1.el9_4.x86_64.r 782 kB/s |  14 MB     00:18
    bal: --------------------------------------------------------------------------------
    bal: Total                                           1.7 MB/s |  34 MB     00:19
    bal: Running transaction check
    bal: Transaction check succeeded.
    bal: Running transaction test
    bal: Transaction test succeeded.
    bal: Running transaction
    bal:   Running scriptlet: npm-1:8.19.4-1.16.20.2.8.0.1.el9_4.x86_64              1/1
    bal:   Preparing        :                                                        1/1
    bal:   Installing       : nodejs-libs-1:16.20.2-8.0.1.el9_4.x86_64               1/5
    bal:   Installing       : nodejs-docs-1:16.20.2-8.0.1.el9_4.noarch               2/5
    bal:   Installing       : nodejs-full-i18n-1:16.20.2-8.0.1.el9_4.x86_64          3/5
    bal:   Installing       : npm-1:8.19.4-1.16.20.2.8.0.1.el9_4.x86_64              4/5
    bal:   Installing       : nodejs-1:16.20.2-8.0.1.el9_4.x86_64                    5/5
    bal:   Running scriptlet: nodejs-1:16.20.2-8.0.1.el9_4.x86_64                    5/5
    bal:   Verifying        : nodejs-1:16.20.2-8.0.1.el9_4.x86_64                    1/5
    bal:   Verifying        : nodejs-docs-1:16.20.2-8.0.1.el9_4.noarch               2/5
    bal:   Verifying        : nodejs-full-i18n-1:16.20.2-8.0.1.el9_4.x86_64          3/5
    bal:   Verifying        : nodejs-libs-1:16.20.2-8.0.1.el9_4.x86_64               4/5
    bal:   Verifying        : npm-1:8.19.4-1.16.20.2.8.0.1.el9_4.x86_64              5/5
    bal:
    bal: Installed:
    bal:   nodejs-1:16.20.2-8.0.1.el9_4.x86_64
    bal:   nodejs-docs-1:16.20.2-8.0.1.el9_4.noarch
    bal:   nodejs-full-i18n-1:16.20.2-8.0.1.el9_4.x86_64
    bal:   nodejs-libs-1:16.20.2-8.0.1.el9_4.x86_64
    bal:   npm-1:8.19.4-1.16.20.2.8.0.1.el9_4.x86_64
    bal:
    bal: Complete!
==> bal: Running provisioner: shell...
    bal: Running: inline script
    bal: Created symlink /etc/systemd/system/dbus-org.fedoraproject.FirewallD1.service → /usr/lib/systemd/system/firewalld.service.
    bal: Created symlink /etc/systemd/system/multi-user.target.wants/firewalld.service → /usr/lib/systemd/system/firewalld.service.
    bal: success
    bal: success
==> bal: Running provisioner: file...
    bal: files/nginx.conf => /home/vagrant/nginx.conf
==> bal: Running provisioner: shell...
    bal: Running: inline script
    bal: Relabeled /etc/nginx/nginx.conf from unconfined_u:object_r:user_home_t:s0 to unconfined_u:object_r:httpd_config_t:s0
    bal: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
    bal: nginx: configuration file /etc/nginx/nginx.conf test is successful
    bal: ● nginx.service - The nginx HTTP and reverse proxy server
    bal:      Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; preset: disabled)
    bal:      Active: active (running) since Fri 2025-03-21 11:28:03 UTC; 62ms ago
    bal:     Process: 16942 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
    bal:     Process: 16943 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
    bal:     Process: 16944 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
    bal:    Main PID: 16945 (nginx)
    bal:       Tasks: 2 (limit: 5759)
    bal:      Memory: 1.5M
    bal:         CPU: 48ms
    bal:      CGroup: /system.slice/nginx.service
    bal:              ├─16945 "nginx: master process /usr/sbin/nginx"
    bal:              └─16947 "nginx: worker process"
    bal:
    bal: Mar 21 11:28:03 balancer systemd[1]: Starting The nginx HTTP and reverse proxy server...
    bal: Mar 21 11:28:03 balancer nginx[16943]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
    bal: Mar 21 11:28:03 balancer nginx[16943]: nginx: configuration file /etc/nginx/nginx.conf test is successful
    bal: Mar 21 11:28:03 balancer systemd[1]: Started The nginx HTTP and reverse proxy server.
```

---

### Verifying load balancing

0. `vagrant ssh bal` to access *balancer* VM.  

1. `curl <ip-backup>` to verify port opening and app running.  

```bash
[vagrant@balancer ~]$ curl http://192.168.33.12:3001
I am an endpoint
[vagrant@balancer ~]$ curl http://192.168.33.11:3000
I am an endpoint
[vagrant@balancer ~]$ curl http://192.168.33.12:3001
I am an endpoint
[vagrant@balancer ~]$ curl http://192.168.33.13:3002
I am an endpoint 
```

2. `curl -v http://192.168.33.10` to **test** load balancing.  

```sh
*   Trying 192.168.33.10:80...
* Connected to 192.168.33.10 (192.168.33.10) port 80 (#0)
> GET / HTTP/1.1
> Host: 192.168.33.10
> User-Agent: curl/7.76.1
> Accept: */*
>
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Server: nginx/1.20.1
< Date: Fri, 21 Mar 2025 12:36:06 GMT
< Content-Type: text/html; charset=utf-8
< Content-Length: 17
< Connection: keep-alive
< X-Powered-By: Express
< ETag: W/"11-2P3ROHAbCcnyk7GXhvlPWjPVDPs"
< X-Backend-Server: 192.168.33.11:3000
<
I am an endpoint
* Connection #0 to host 192.168.33.10 left intact
```

```sh
*   Trying 192.168.33.10:80...
* Connected to 192.168.33.10 (192.168.33.10) port 80 (#0)
> GET / HTTP/1.1
> Host: 192.168.33.10
> User-Agent: curl/7.76.1
> Accept: */*
>
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Server: nginx/1.20.1
< Date: Fri, 21 Mar 2025 12:36:10 GMT
< Content-Type: text/html; charset=utf-8
< Content-Length: 17
< Connection: keep-alive
< X-Powered-By: Express
< ETag: W/"11-2P3ROHAbCcnyk7GXhvlPWjPVDPs"
< X-Backend-Server: 192.168.33.12:3001
<
I am an endpoint
* Connection #0 to host 192.168.33.10 left intact
```

3. Automate testing.  

```bash
for _ in {1..15}; do 
    curl -s -v http://192.168.33.10 2>&1 | grep 'X-Backend-Server' >> load_balancing_test.log 
done 
cat load_balancing_test.log
```

**Output**:  

```json
< X-Backend-Server: 192.168.33.13:3002
< X-Backend-Server: 192.168.33.11:3000
< X-Backend-Server: 192.168.33.12:3001
< X-Backend-Server: 192.168.33.13:3002
< X-Backend-Server: 192.168.33.11:3000
< X-Backend-Server: 192.168.33.12:3001
< X-Backend-Server: 192.168.33.13:3002
< X-Backend-Server: 192.168.33.11:3000
< X-Backend-Server: 192.168.33.12:3001
< X-Backend-Server: 192.168.33.13:3002
< X-Backend-Server: 192.168.33.11:3000
< X-Backend-Server: 192.168.33.12:3001
< X-Backend-Server: 192.168.33.13:3002
< X-Backend-Server: 192.168.33.11:3000
< X-Backend-Server: 192.168.33.12:3001
```

4. Check rsponse from browser: `lynx http://localhost`.  

---

## Results

**Nginx** [configuration file](https://github.com/nromanen/devops_2025/blob/main/kateryna_kravchuk/task_12/vms_lb/files/nginx.conf) and [screenshot](https://drive.google.com/file/d/1FBxjElGHh379I5AwjRVHkQyHQ9FzQiZz/view?usp=sharing) demonstrating the response page.  
