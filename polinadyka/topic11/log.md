# MongoDB Setup and Operations Log

## 1. Start MongoDB Shell
```bash
mongosh
```

## 2. Create Database `polina`
```bash
use polina
```

## 3. Add three documents to the database that include the following details about your favorite books: Title, Author, Year of Publication, Number of Pages, Number of Copies
```bash
db.books.insertMany([
    {
        "title": "Кайдашева сім’я",
        "author": "Іван Нечуй-Левицький",
        "year": 1879,
        "pages": 256,
        "copies": 5
    },
    {
        "title": "Тіні забутих предків",
        "author": "Михайло Коцюбинський",
        "year": 1911,
        "pages": 240,
        "copies": 3
    },
    {
        "title": "Місто",
        "author": "Валер’ян Підмогильний",
        "year": 1928,
        "pages": 312,
        "copies": 4
    }
])
```

## 4. Update book information: modify the number of copies for the first book you entered
```bash
db.books.updateOne(
    { "title": "Кайдашева сім’я" },
    { $set: { "copies": 10 } }
)
```

## 5. Query for books: find all books published in the same year as one of the books you entered
```bash
db.books.find({ "year": 1911 })
```

## 6. The same but on my VM:
```bash
polina@ubuntu:~$ wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -c --short)/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
sudo apt update
sudo apt install -y mongodb-org
Warning: apt-key is deprecated. Manage keyring files in trusted.gpg.d instead (see apt-key(8)).
OK
deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/6.0 multiverse
Hit:1 http://ports.ubuntu.com/ubuntu-ports noble InRelease
Hit:2 http://ports.ubuntu.com/ubuntu-ports noble-updates InRelease
Hit:3 http://ports.ubuntu.com/ubuntu-ports noble-backports InRelease
Hit:4 http://ports.ubuntu.com/ubuntu-ports noble-security InRelease
Ign:5 https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/6.0 InRelease
Ign:6 https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/7.0 InRelease
Err:7 https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/6.0 Release
  404  Not Found [IP: 18.66.233.24 443]
Err:8 https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/7.0 Release
  404  Not Found [IP: 18.66.233.24 443]
Reading package lists... Done
E: The repository 'https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/6.0 Release' does not have a Release file.
N: Updating from such a repository can't be done securely, and is therefore disabled by default.
N: See apt-secure(8) manpage for repository creation and user configuration details.
E: The repository 'https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/7.0 Release' does not have a Release file.
N: Updating from such a repository can't be done securely, and is therefore disabled by default.
N: See apt-secure(8) manpage for repository creation and user configuration details.
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
E: Unable to locate package mongodb-org
polina@ubuntu:~$ curl -fsSL https://pgp.mongodb.com/server-6.0.asc | sudo tee /usr/share/keyrings/mongodb-server-key.asc
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.4.11 (GNU/Linux)

mQINBGIWTroBEADgSBs1z1MC5Hog5yd2wYHskzPE0SOl9LGB35Xhw1894hrKsswp
AS7JnViltXE71iJMoAqepJBvfmZLOyQO0rXcLlHXExK/IctnosRqGQeyLxNZKS0h
e1xQYQrPCWRaHqseYLuJ5wME49aFQ2YS7caFowBvKjsT5AoT7B0uXDp6nHZDUQG2
MBZJqUKziVYYt7PARv81llDNKqPvLDSc2McL/2aa4mNR/pM5r8iQjACbSnj37ERm
zca2gJ0GzCeZSqfmjoF7I6Ez1Nc/2ge1+fZA24pDFg+7W25du3JIqbnpJQAK5TAz
7tVzvEKU8WT9aQW3G1e5ox3YtlRPTSrTxN9dzLh123NGCd0J9a4moFkZIr8HmySd
jkdz4V1pKv9aTOhLjQpF/bhRaUuNuGK7TV7ZzY+PCVE51fmJx2EX4Ck5c6sW03rJ
59KbrxeTq02AcIBTFUY0Mfh7nxvYvwvLI0OKBOqFGXi4hFXpV4uo0rDLe+tGLFDD
+HsajFUUyAlMETE80PXOuTs44TZiW+SGCTyP2Sm8TBIiacSqsGNsryjgEDaIG6c1
FB++njqTfGlyZujamYbF3s3wBK8nDBVRympJcsHjLqUhvbh1Bq4hyF2pxio93SgA
mPEm6kl0KBCqpJNZpAFSVHK8penQtQUa0jFQetYPDUFfgTsg7qdZDQNcUwARAQAB
tDdNb25nb0RCIDYuMCBSZWxlYXNlIFNpZ25pbmcgS2V5IDxwYWNrYWdpbmdAbW9u
Z29kYi5jb20+iQI+BBMBAgAoBQJiFk66AhsDBQkJZgGABgsJCAcDAgYVCAIJCgsE
FgIDAQIeAQIXgAAKCRBqJrGuZMPDiADhEACex1qu1HbVIeBwZO4GYYEc8OpswguI
LvTL1ufWMVbpSFkm0XDzx7JU0SewCEBzr7BTri2zjNaPm7RQHYFl1ztTnNvxrvzu
AUoj/BClAgQXujSuUcEu+uA9pBHObiLHAkYFy61EnKgXu2iTOMn7HqRvjvHZyOnr
5llGG2zUq8YbEVs4GTHVV9CjCWBkf78stdqEAPCH69DtR1Bv2jQfUslVSDKUnluX
feTRDgWXnIKo4ld6EoqtYurIbcJIGvXHbFx90PoZiPJXn+eTY+6HS3I/TXDGAOkF
xkgmVsPWcZvbU0dLXjAiTIADODyiEiZlonrxYXJztIs/KXLl5CnvAEeXKXACbgaN
nuIMKtprtrLvFDpXwfyI90He0Vv8iE1wXSLcuztT5R1h6NmisMz9oRYQL3hqsSEn
TjV+Ko34Kyo459Bs9PhJO0DcZGg+B8iU9TdJgfp1KEs2HJFAueVtYAUJ3y5+UJFn
AkQoD5CC0Y+93z0+nHQPvjyxQ/7swFWNtrumrthcpYbGMIKEWqaQoEz2My5gVXHh
v5pHEXxXiARNe44GsS8r+1DYQypDUAh5Tw9mQRagWuC5Dsaaqob5vCdcFEAgiK5W
a/coP3B6WzUoQE8NKa8qnKDvX5RU0dxG5oUre+PuOwiHpom9G+375YYkwIL9a6pE
RRM5efxf1F532A==
=Cc71
-----END PGP PUBLIC KEY BLOCK-----
polina@ubuntu:~$ echo "deb [signed-by=/usr/share/keyrings/mongodb-server-key.asc] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
deb [signed-by=/usr/share/keyrings/mongodb-server-key.asc] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse
polina@ubuntu:~$ sudo apt update
Hit:1 http://ports.ubuntu.com/ubuntu-ports noble InRelease
Hit:2 http://ports.ubuntu.com/ubuntu-ports noble-updates InRelease
Hit:3 http://ports.ubuntu.com/ubuntu-ports noble-backports InRelease
Hit:4 http://ports.ubuntu.com/ubuntu-ports noble-security InRelease
Get:5 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 InRelease [4,009 B]
Ign:6 https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/7.0 InRelease
Get:7 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0/multiverse arm64 Packages [83.1 kB]
Err:8 https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/7.0 Release
  404  Not Found [IP: 18.66.233.75 443]
Reading package lists... Done
E: The repository 'https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/7.0 Release' does not have a Release file.
N: Updating from such a repository can't be done securely, and is therefore disabled by default.
N: See apt-secure(8) manpage for repository creation and user configuration details.
polina@ubuntu:~$ sudo rm /etc/apt/sources.list.d/mongodb-org-7.0.list
polina@ubuntu:~$ sudo apt update
sudo apt install -y mongodb-org
Hit:1 http://ports.ubuntu.com/ubuntu-ports noble InRelease
Hit:2 http://ports.ubuntu.com/ubuntu-ports noble-updates InRelease
Hit:3 http://ports.ubuntu.com/ubuntu-ports noble-backports InRelease
Hit:4 http://ports.ubuntu.com/ubuntu-ports noble-security InRelease
Hit:5 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 InRelease
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
9 packages can be upgraded. Run 'apt list --upgradable' to see them.
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  mongodb-database-tools mongodb-mongosh mongodb-org-database mongodb-org-database-tools-extra mongodb-org-mongos mongodb-org-server mongodb-org-shell mongodb-org-tools
The following NEW packages will be installed:
  mongodb-database-tools mongodb-mongosh mongodb-org mongodb-org-database mongodb-org-database-tools-extra mongodb-org-mongos mongodb-org-server mongodb-org-shell
  mongodb-org-tools
0 upgraded, 9 newly installed, 0 to remove and 9 not upgraded.
Need to get 153 MB of archives.
After this operation, 495 MB of additional disk space will be used.
Get:1 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0/multiverse arm64 mongodb-database-tools arm64 100.11.0 [50.1 MB]
Get:2 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0/multiverse arm64 mongodb-mongosh arm64 2.4.2 [50.8 MB]
Get:3 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0/multiverse arm64 mongodb-org-shell arm64 6.0.20 [2,984 B]                                                 
Get:4 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0/multiverse arm64 mongodb-org-server arm64 6.0.20 [30.0 MB]                                                
Get:5 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0/multiverse arm64 mongodb-org-mongos arm64 6.0.20 [21.7 MB]                                                
Get:6 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0/multiverse arm64 mongodb-org-database-tools-extra arm64 6.0.20 [7,782 B]                                  
Get:7 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0/multiverse arm64 mongodb-org-database arm64 6.0.20 [3,422 B]                                              
Get:8 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0/multiverse arm64 mongodb-org-tools arm64 6.0.20 [2,772 B]                                                 
Get:9 https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0/multiverse arm64 mongodb-org arm64 6.0.20 [2,806 B]                                                       
Fetched 153 MB in 13s (11.8 MB/s)                                                                                                                                         
Selecting previously unselected package mongodb-database-tools.
(Reading database ... 134136 files and directories currently installed.)
Preparing to unpack .../0-mongodb-database-tools_100.11.0_arm64.deb ...
Unpacking mongodb-database-tools (100.11.0) ...
Selecting previously unselected package mongodb-mongosh.
Preparing to unpack .../1-mongodb-mongosh_2.4.2_arm64.deb ...
Unpacking mongodb-mongosh (2.4.2) ...
Selecting previously unselected package mongodb-org-shell.
Preparing to unpack .../2-mongodb-org-shell_6.0.20_arm64.deb ...
Unpacking mongodb-org-shell (6.0.20) ...
Selecting previously unselected package mongodb-org-server.
Preparing to unpack .../3-mongodb-org-server_6.0.20_arm64.deb ...
Unpacking mongodb-org-server (6.0.20) ...
Selecting previously unselected package mongodb-org-mongos.
Preparing to unpack .../4-mongodb-org-mongos_6.0.20_arm64.deb ...
Unpacking mongodb-org-mongos (6.0.20) ...
Selecting previously unselected package mongodb-org-database-tools-extra.
Preparing to unpack .../5-mongodb-org-database-tools-extra_6.0.20_arm64.deb ...
Unpacking mongodb-org-database-tools-extra (6.0.20) ...
Selecting previously unselected package mongodb-org-database.
Preparing to unpack .../6-mongodb-org-database_6.0.20_arm64.deb ...
Unpacking mongodb-org-database (6.0.20) ...
Selecting previously unselected package mongodb-org-tools.
Preparing to unpack .../7-mongodb-org-tools_6.0.20_arm64.deb ...
Unpacking mongodb-org-tools (6.0.20) ...
Selecting previously unselected package mongodb-org.
Preparing to unpack .../8-mongodb-org_6.0.20_arm64.deb ...
Unpacking mongodb-org (6.0.20) ...
Setting up mongodb-mongosh (2.4.2) ...
Setting up mongodb-org-server (6.0.20) ...
info: Selecting UID from range 100 to 999 ...

info: Adding system user `mongodb' (UID 110) ...
info: Adding new user `mongodb' (UID 110) with group `nogroup' ...
info: Not creating `/nonexistent'.
info: Selecting GID from range 100 to 999 ...
info: Adding group `mongodb' (GID 110) ...
info: Adding user `mongodb' to group `mongodb' ...
Setting up mongodb-org-shell (6.0.20) ...
Setting up mongodb-database-tools (100.11.0) ...
Setting up mongodb-org-mongos (6.0.20) ...
Setting up mongodb-org-database-tools-extra (6.0.20) ...
Setting up mongodb-org-database (6.0.20) ...
Setting up mongodb-org-tools (6.0.20) ...
Setting up mongodb-org (6.0.20) ...
Processing triggers for man-db (2.12.0-4build2) ...
Scanning processes...                                                                                                                                                      
Scanning linux images...                                                                                                                                                   

Running kernel seems to be up-to-date.

No services need to be restarted.

No containers need to be restarted.

No user sessions are running outdated binaries.

No VM guests are running outdated hypervisor (qemu) binaries on this host.
polina@ubuntu:~$ sudo systemctl start mongod
polina@ubuntu:~$ sudo systemctl status mongod
● mongod.service - MongoDB Database Server
     Loaded: loaded (/usr/lib/systemd/system/mongod.service; disabled; preset: enabled)
     Active: active (running) since Sat 2025-03-15 12:14:24 UTC; 9s ago
       Docs: https://docs.mongodb.org/manual
   Main PID: 3276 (mongod)
     Memory: 67.2M (peak: 67.7M)
        CPU: 1.206s
     CGroup: /system.slice/mongod.service
             └─3276 /usr/bin/mongod --config /etc/mongod.conf

Mar 15 12:14:24 ubuntu systemd[1]: Started mongod.service - MongoDB Database Server.
Mar 15 12:14:24 ubuntu mongod[3276]: {"t":{"$date":"2025-03-15T12:14:24.637Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"-","msg":"Environment variable MONGODB_CONFI>
set mark: ...skipping...
```
```bash
polina@ubuntu:~$ mongosh
Current Mongosh Log ID:	67d56f3a6b9b139534300588
Connecting to:		mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.4.2
Using MongoDB:		6.0.20
Using Mongosh:		2.4.2

For mongosh info see: https://www.mongodb.com/docs/mongodb-shell/


To help improve our products, anonymous usage data is collected and sent to MongoDB periodically (https://www.mongodb.com/legal/privacy-policy).
You can opt-out by running the disableTelemetry() command.

------
   The server generated these startup warnings when booting
   2025-03-15T12:14:24.688+00:00: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine. See http://dochub.mongodb.org/core/prodnotes-filesystem
   2025-03-15T12:14:25.777+00:00: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
------

test> db.books.insertMany([
...     {
...         "title": "Кайдашева сім’я",
...         "author": "Іван Нечуй-Левицький",
...         "year": 1879,
...         "pages": 256,
...         "copies": 5
...     },
...     {
...         "title": "Тіні забутих предків",
...         "author": "Михайло Коцюбинський",
...         "year": 1911,
...         "pages": 240,
...         "copies": 3
...     },
...     {
...         "title": "Місто",
...         "author": "Валер’ян Підмогильний",
...         "year": 1928,
...         "pages": 312,
...         "copies": 4
...     }
... ])
... 
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId('67d56f576b9b139534300589'),
    '1': ObjectId('67d56f576b9b13953430058a'),
    '2': ObjectId('67d56f576b9b13953430058b')
  }
}
test> db.books.updateOne(
...     { "title": "Кайдашева сім’я" },
...     { $set: { "copies": 10 } }
... )
... 
{
  acknowledged: true,
  insertedId: null,
  matchedCount: 1,
  modifiedCount: 1,
  upsertedCount: 0
}
test> db.books.find({ "year": 1911 })
... 
[
  {
    _id: ObjectId('67d56f576b9b13953430058a'),
    title: 'Тіні забутих предків',
    author: 'Михайло Коцюбинський',
    year: 1911,
    pages: 240,
    copies: 3
  }
]
test> 
```