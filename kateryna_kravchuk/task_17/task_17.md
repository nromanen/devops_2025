# Task 17: Cloud Computing

> Done by [@Lians-coder](https://github.com/Lians-coder) (Kateryna Kravchuk)

---

## Preparation

Register on the Azure Portal: Create an account and register on the Azure Portal.  

---

## Virtual Machine

Set up a virtual machine in Azure and install a Linux operating system (any distribution).  

### Ubuntu VM

VM **specifications** can be found in the [screenshot](https://drive.google.com/file/d/1OZWenOzrP-QbCCVHf2VVRhI8Z8lAJDk9/view?usp=drive_link) or as a JSON object below:  

```json
{
    "name": "ubuntu-iaas",
    "id": "/subscriptions/<subscription-id>/resourceGroups/devopsv/providers/Microsoft.Compute/virtualMachines/ubuntu-iaas",
    "type": "Microsoft.Compute/virtualMachines",
    "location": "polandcentral",
    "properties": {
        "hardwareProfile": {
            "vmSize": "Standard_B1s"
        },
        "provisioningState": "Succeeded",
        "vmId": "<some-id>",
        "additionalCapabilities": {
            "hibernationEnabled": false
        },
        "storageProfile": {
            "imageReference": {
                "publisher": "canonical",
                "offer": "ubuntu-24_04-lts",
                "sku": "server",
                "version": "latest",
                "exactVersion": "24.04.202502210"
            },
            "osDisk": {
                "osType": "Linux",
                "name": "ubuntu-iaas_OsDisk_1_<some-id>",
                "createOption": "FromImage",
                "caching": "ReadWrite",
                "managedDisk": {
                    "id": "/subscriptions/<subscription-id>/resourceGroups/devopsv/providers/Microsoft.Compute/disks/ubuntu-iaas_OsDisk_1_<some-value>"
                },
                "deleteOption": "Delete"
            },
            "dataDisks": []
        },
        "osProfile": {
            "computerName": "ubuntu-iaas",
            "adminUsername": "azureuser",
            "linuxConfiguration": {
                "disablePasswordAuthentication": true,
                "ssh": {
                    "publicKeys": [
                        {
                            "path": "/home/azureuser/.ssh/authorized_keys",
                            "keyData": "ssh-rsa <some-value>= generated-by-azure"
                        }
                    ]
                },
                "provisionVMAgent": true,
                "patchSettings": {
                    "patchMode": "ImageDefault",
                    "assessmentMode": "ImageDefault"
                }
            },
            "secrets": [],
            "allowExtensionOperations": true,
            "requireGuestProvisionSignal": true
        },
        "networkProfile": {
            "networkInterfaces": [
                {
                    "id": "/subscriptions/<subscription-id>/resourceGroups/devopsv/providers/Microsoft.Network/networkInterfaces/ubuntu-iaas750_z1",
                    "properties": {
                        "deleteOption": "Delete"
                    }
                }
            ]
        },
        "diagnosticsProfile": {
            "bootDiagnostics": {
                "enabled": true
            }
        }
    },
    "zones": [
        "1"
    ],
    "apiVersion": "2021-03-01"
}
```

### Gain access

> Steps 1–2 apply only when connecting from a Windows machine.  

1. Open *Command Prompt* as Administrator.  
2. Restrict permissions on the PEM key:  

```powershell
icacls "<some-path>\ubuntu-iaas_key.pem" /inheritance:r
icacls "<some-path>\ubuntu-iaas_key.pem" /grant:r %USERNAME%:R
```

**Notes on commands**:  
    1. `/inheritance:r` removes inherited permissions.  
    2. `/grant:r` grants read-only permissions for the current user.  

**Output**:  

```cmd
processed file: <some-path>\ubuntu-iaas_key.pem
Successfully processed 1 files; Failed processing 0 files

processed file: <some-path>\ubuntu-iaas_key.pem
Successfully processed 1 files; Failed processing 0 files
```

3. Use the PEM key to connect to the VM via **PowerShell** (run as Administrator).  

> To obtain the VM's IP, go to the Connect [tab](https://drive.google.com/file/d/1Fl5q3DyHhhrHSu-cC4Y4C9aqkkS4Jyyo/view?usp=drive_link) on the Azure portal.  

```bash
ssh -i <some-path>/ubuntu-iaas_key.pem azureuser@20.215.33.108
```

---

## Task

Install and deploy on a Virtual Machine in Azure with Linux the [Blood-Bank-Management-System](https://github.com/DevOps2-Fundamentals/Blood-Bank-Management-System).  

### Install XAMPP on the VM

Download XAMPP:

```bash
sudo apt update
wget https://sourceforge.net/projects/xampp/files/XAMPP%20Linux/8.2.12/xampp-linux-x64-8.2.12-0-installer.run
chmod +x xampp-linux-x64-8.2.12-0-installer.run # Make the installer executable
sudo ./xampp-linux-x64-8.2.12-0-installer.run # Run the installer
```

**Output**:  

```txt
[...]
HTTP request sent, awaiting response... 200 OK
Length: 160483784 (153M) [application/x-makeself]
Saving to: ‘xampp-linux-x64-8.2.12-0-installer.run’

xampp-linux-x64-8.2.12-0-installer.run                     100%[=======================================================================================================================================>] 153.05M  8.82MB/s    in 17s      

2025-04-13 18:07:22 (9.02 MB/s) - ‘xampp-linux-x64-8.2.12-0-installer.run’ saved [160483784/160483784]

----------------------------------------------------------------------------
Welcome to the XAMPP Setup Wizard.

----------------------------------------------------------------------------
Select the components you want to install; clear the components you do not want 
to install. Click Next when you are ready to continue.

XAMPP Core Files : Y (Cannot be edited)

XAMPP Developer Files [Y/n] :Y

Is the selection above correct? [Y/n]: Y

----------------------------------------------------------------------------
Installation Directory

XAMPP will be installed to /opt/lampp
Press [Enter] to continue:

----------------------------------------------------------------------------
Setup is now ready to begin installing XAMPP on your computer.

Do you want to continue? [Y/n]: Y

----------------------------------------------------------------------------
Please wait while Setup installs XAMPP on your computer.

 Installing
 0% ______________ 50% ______________ 100%
 #########################################

----------------------------------------------------------------------------
Setup has finished installing XAMPP on your computer.
```

### Install Java JDK

```bash
sudo apt install -y openjdk-17-jdk
java -version
javac -version
```

**Output**:  

```bash
openjdk version "17.0.14" 2025-01-21
OpenJDK Runtime Environment (build 17.0.14+7-Ubuntu-124.04)
OpenJDK 64-Bit Server VM (build 17.0.14+7-Ubuntu-124.04, mixed mode, sharing)
javac 17.0.14
```

---

## Application setup

### Download project files

```bash
sudo apt update
sudo apt install -y unzip

# Get the files
wget https://github.com/DevOps2-Fundamentals/Blood-Bank-Management-System/archive/refs/heads/main.zip
unzip main.zip
rm main.zip

# Move it in XAMPP
sudo mv Blood-Bank-Management-System-main /opt/lampp/htdocs/
```

### Start XAMPP

```bash
sudo /opt/lampp/lampp start
```

> If you encounter the error `netstat: command not found`, install it with `sudo apt install net-tools`.  

**Output**:  

```bash
Starting XAMPP for Linux 8.2.12-0...
XAMPP: Starting Apache...ok.
XAMPP: Starting MySQL...ok.
XAMPP: Starting ProFTPD...ok.
```

---

## Database setup

Set Up an SQL Database in Azure: Deploy and configure an SQL database in the Azure environment.  

### Azure MySQL Database

To allow connections, modify XAMPP's configuration file: `sudo nano /opt/lampp/etc/extra/httpd-xampp.conf`.  

Replace the relevant block with:  

```xml
<Directory "/opt/lampp/phpmyadmin">
    AllowOverride AuthConfig
    Require all granted
</Directory>
```

Restart XAMPP by `sudo /opt/lampp/lampp restart`.  

**Output**:  

```bash
Restarting XAMPP for Linux 8.2.12-0...
XAMPP: Stopping Apache...ok.
XAMPP: Stopping MySQL...ok.
XAMPP: Stopping ProFTPD...ok.
XAMPP: Starting Apache...ok.
XAMPP: Starting MySQL...ok.
XAMPP: Starting ProFTPD...ok.
```

### (alternative) Azure MySQL Database as IaaS

There is another option to create a SQL database by using dedicated IaaS on Azure Portal, that have additional benefits compared to the DB on the standart VM.  

1. Go to Azure Portal -> *Azure Database for MySQL* -> *Create MySQL Database*. Provide all the necessary information, create a dedicated SQL server and navigate to it.  
2. *Set server firewall* -> open **Terminal**, select *Azure CLI*, add the following:  

```bash
az sql server firewall-rule create --resource-group devopsv --server bloodbank-server --name AllowAllWindowsAzureIps --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0
```

**Output**:  

```json
{
  "endIpAddress": "0.0.0.0",
  "id": "/subscriptions/<subscription_id>/resourceGroups/devopsv/providers/Microsoft.Sql/servers/bloodbank-server/firewallRules/AllowAllWindowsAzureIps",
  "name": "AllowAllWindowsAzureIps",
  "resourceGroup": "devopsv",
  "startIpAddress": "0.0.0.0",
  "type": "Microsoft.Sql/servers/firewallRules"
}
```

### Access phpMyAdmin

Navigate to the *phpmyadmin* for the further DB configuration:  
    1. in a browser: `http://20.215.33.108/phpmyadmin/`;  
    2. via terminal: `sudo /opt/lampp/bin/mysql -u root`.  

> The following steps are terminal-based.  

#### Create Database and Import SQL

```bash
# Create 'bloodbank' DB
sudo /opt/lampp/bin/mysql -u root -e "CREATE DATABASE bloodbank;"

# Navigate to the SQL directory and import data
cd /opt/lampp/htdocs/Blood-Bank-Management-System-main/sql
sudo /opt/lampp/bin/mysql -u root bloodbank < bloodbank.sql
```

**Verify import**:  
    1. run `sudo /opt/lampp/bin/mysql -u root bloodbank` to access the database;  
    2. run SQL query `SHOW TABLES;` to check if everything was imported correctly.  

**Output**:  

```txt
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 26
Server version: 10.4.32-MariaDB Source distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [bloodbank]> SHOW TABLES;
+---------------------+
| Tables_in_bloodbank |
+---------------------+
| blooddinfo          |
| blooddonate         |
| bloodinfo           |
| bloodrequest        |
| hospitals           |
| receivers           |
+---------------------+
6 rows in set (0.000 sec)
```

---

## Functionality

Check the operation of the application from the browser.  

### Running

Access the application in a browser:  

```bash
http://20.215.33.108/Blood-Bank-Management-System-main
```

---

## Results

All the [screenshots](https://drive.google.com/drive/folders/1RLIOoMKD39Llcai2a0R5Ag_6uYE0mK1S?usp=drive_link) documenting the steps and outcome.  

---

## Cleanup and resource management

To delete the entire resource group (including the VM and related resources), use the **Azure CLI**:  

```bash
az group delete --name 'devopsv' --yes --no-wait
```

To disable and remove *Network Watcher* for your region:  

```bash
az network watcher configure --locations polandcentral --enabled false
```

**Output**:  

```bash
Disabling Network Watcher for region 'polandcentral' by deleting resource '/subscriptions/<subscription_id>/resourceGroups/NetworkWatcherRG/providers/Microsoft.Network/networkWatchers/NetworkWatcher_polandcentral'
[]
```

To verify the success of the operations, navigate to **All Resourses** [tab](https://drive.google.com/file/d/1SzY5Hu8yVPqNR0zTxRjCJspCfO-_BQhY/view?usp=drive_link) and confirm that no resources are listed.  
