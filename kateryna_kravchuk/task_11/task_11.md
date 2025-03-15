# Task 11: NoSQL

> Done by [@Lians-coder](https://github.com/Lians-coder) (Kateryna Kravchuk)

---

## KillerCoda

### Task 1: Installation

Launch the environment on KillerCoda by visiting https://killercoda.com/online-marathon/course/DevOps_dev/Setup_mongodb and follow all the provided steps.  

#### 1.1 Update the package list: `sudo apt update`

#### 1.2. Install Required Dependencies for MongoDB 4.4

```bash
sudo apt install libssl1.1
sudo apt update
sudo apt-get install gnupg
```

**OpenSSL 1.1** is required by older versions of MongoDB (like 4.4) (Ubuntu versions 22.04+ have *OpenSSL 3*).  
**GnuPG** is a tool for handling cryptographic signatures, it is required for adding the MongoDB GPG key, which verifies the authenticity of MongoDB packages.  

#### 1.3. Add the MongoDB 4.4 repository

```bash
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -c --short)/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt-get update
```

`apt-key add -` adds the key to the system, so *apt* trusts the MongoDB repository.  
`$(lsb_release -c --short)` dynamically inserts the Ubuntu codename (e.g., *focal* for Ubuntu 20.04).  

#### 1.4. Install MongoDB 4.4

```bash
sudo apt-get install -y mongodb-org=4.4.11 mongodb-org-server=4.4.11 mongodb-org-shell=4.4.11 mongodb-org-mongos=4.4.11 mongodb-org-tools=4.4.11
```

| Component | Purpose |
| --- | --- |
| `mongodb-org` | Meta package for MongoDB |
| `mongodb-org-server` | The database server |
| `mongodb-org-shell` | The command-line shell (*mongosh*) |
| `mongodb-org-mongos` | The MongoDB router (for sharded clusters) |
| `mongodb-org-tools` | Backup and monitoring tools |

#### 1.5. Start and verify MongoDB

```bash
sudo systemctl start mongod
sudo systemctl status mongod
```

#### 1.6. Upgrade to MongoDB 6.0

```bash
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
apt-get install gnupg

echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
sudo apt update
```

> Installing *GnuPG* and adding the MongoDB 6.0 *GPG key* are redundant steps, since we installed ans added it previously.  

#### 1.7. Install the latest stable version of *mongosh*

With the included OpenSSL libraries: `sudo apt install -y mongodb-mongosh`.  
Or with *OpenSSL 1.1* libraries: `sudo apt-get install -y mongodb-mongosh-shared-openssl1.1`.  
Or with *OpenSSL 3.0* libraries: `sudo apt-get install -y mongodb-mongosh-shared-openssl3`

---

### Task 2: Using MongoDB

#### 2.1. Run Mongo Shell

`mongosh` or `mongosh "mongodb://localhost:27017"`

```bash
db
show dbs
use softservedb
```

#### 2.2. Insert documents

```js
db.mycol.insertOne(
    {
        title: 'MongoDB Overview', 
        description: 'MongoDB is no sql database', 
        by: 'tutorials point', 
        url: 'http://www.mongodb.com/docs', 
        tags: ['mongodb', 'database', 'NoSQL'], 
        likes: 100 
    }
)
db.mycol.insertOne(
    {
        title: 'Database Overview', 
        description: 'Database is no sql database', 
        by: 'tutorials point', 
        url: 'http://www.mongodb.com/docs', 
        tags: ['mongodb', 'database', 'NoSQL'], 
        likes: 15 
    }
)
```

#### 2.3. Query DB

```js
db.mycol.find().pretty()
db.mycol.find( { "title": "Database Overview" } )
```

#### 2.4. Update information

```js
db.mycol.update({ likes: { $gt: 25 } },{ $set: { title: "Updated!" } }, { multi: true })
```

> It works, but produce this error:  
> "DeprecationWarning: Collection.update() is deprecated. Use updateOne, updateMany, or bulkWrite."  

#### 2.5. Check the results of updating

```js
db.mycol.find({},{ title:1}).pretty()
```

#### 2.6. Count documents and delete it

```js
db.mycol.countDocuments()
db.mycol.remove( { title: "Updated!" } )
```

> Again, it works, but with this errror:  
> "DeprecationWarning: Collection.remove() is deprecated. Use deleteOne, deleteMany, findOneAndDelete, or bulkWrite."  

To check the deletion: `db.mycol.count()`

---

### Task 3

In the last step, create a database named `<your name>` instead of `john_doe`.

#### 3.1 Create DB

```bash
mongosh
use lians
```

#### 3.2 Add documents

Add three documents to the database that include the following details about your favorite books: Title, Author, Year of Publication, Number of Pages, Number of Copies.  

```js
db.mycol.insertMany( [
    {
        title: 'The Little Prince', 
        author: 'Antoine de Saint-Exupéry', 
        year: '1943', 
        pages: 140, 
        copies: 5000
    },
    {
        title: 'The Three-Body Problem', 
        author: 'Liu Cixin', 
        year: '2014', 
        pages: 390, 
        copies: 1000
    },
    {
        title: 'Confessions', 
        author: 'Jaume Cabré', 
        year: '2015', 
        pages: 760, 
        copies: 3000
    }
] )
```

**Output**:

```js
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId('67d40f5bf241cbf1e86b140b'),
    '1': ObjectId('67d40f5bf241cbf1e86b140c'),
    '2': ObjectId('67d40f5bf241cbf1e86b140d')
  }
}
```

#### 3.3 Update information

Update book information: modify the number of copies for the first book you entered.  

```js
db.mycol.updateOne({ title: 'The Three-Body Problem' }, { $set: { copies: 10000 } })
db.mycol.find().pretty()
```

```js
{
  acknowledged: true,
  insertedId: null,
  matchedCount: 1,
  modifiedCount: 1,
  upsertedCount: 0
}
```

**Output**:

```js
[
  {
    _id: ObjectId('67d40f5bf241cbf1e86b140b'),
    title: 'The Little Prince',
    author: 'Antoine de Saint-Exupéry',
    year: '1943',
    pages: 140,
    copies: 5000
  },
  {
    _id: ObjectId('67d40f5bf241cbf1e86b140c'),
    title: 'The Three-Body Problem',
    author: 'Liu Cixin',
    year: '2014',
    pages: 390,
    copies: 10000
  },
  {
    _id: ObjectId('67d40f5bf241cbf1e86b140d'),
    title: 'Confessions',
    author: 'Jaume Cabré',
    year: '2015',
    pages: 760,
    copies: 3000
  }
]
```

#### 3.4. Query

Query for books: find all books published in the same year as one of the books you entered

```js
db.mycol.find({ year: '1943' }).pretty()
```

**Output**:

```js
[
  {
    _id: ObjectId('67d40f5bf241cbf1e86b140b'),
    title: 'The Little Prince',
    author: 'Antoine de Saint-Exupéry',
    year: '1943',
    pages: 140,
    copies: 5000
  }
]
```

---

## Virtual Mashine

### Task 1: Installation on VM

Install MongoDB on your previously created virtual machine with Linux.  

#### 1.1 Update the package list

`sudo apt update && sudo apt upgrade -y`

#### 1.2. Import the MongoDB GPG key

> Install *gnupg* and *curl* before if needed: `sudo apt-get install gnupg curl`  

```bash
curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg --dearmor
```

> The version is most important, as non-compatible one may not run.  

#### 1.3 Install dependencies

```bash
sudo apt install libcurl4-openssl-dev libssl-dev
sudo apt-get install libcurl4 libgssapi-krb5-2 libldap2 libwrap0 libsasl2-2 libsasl2-modules libsasl2-modules-gssapi-mit openssl liblzma5 -y
```

#### 1.4. Add the MongoDB repository

```bash
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
sudo apt update
```

**Output**:  

```bash
Hit:1 http://security.ubuntu.com/ubuntu noble-security InRelease
Hit:2 http://ca.archive.ubuntu.com/ubuntu noble InRelease
Hit:3 http://ca.archive.ubuntu.com/ubuntu noble-updates InRelease
Hit:4 http://ca.archive.ubuntu.com/ubuntu noble-backports InRelease
Hit:5 https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 InRelease
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
2 packages can be upgraded. Run 'apt list --upgradable' to see them.
```

#### 1.5. Install MongoDB

```bash
sudo apt install -y mongodb-org
```
> Notice that the installation of this meta-package will install all the tools and the server together, giving a complete MongoDB setup.  

This part of the **output** shows what have beed done and what tools were installed:  

```bash
Setting up mongodb-org-server (8.0.5) ...
Setting up mongodb-org-shell (8.0.5) ...
Setting up mongodb-database-tools (100.11.0) ...
Setting up mongodb-org-mongos (8.0.5) ...
Setting up mongodb-org-database-tools-extra (8.0.5) ...
Setting up mongodb-org-database (8.0.5) ...
Setting up mongodb-org-tools (8.0.5) ...
Setting up mongodb-org (8.0.5) ...
Processing triggers for man-db (2.12.0-4build2) ...
```

#### 1.6. Start  MongoDB

```bash
sudo systemctl start mongod
sudo systemctl status mongod
```

**Output**:  

```bash
sudo systemctl status mongod
● mongod.service - MongoDB Database Server
     Loaded: loaded (/usr/lib/systemd/system/mongod.service; disabled; preset: enabled)
     Active: active (running) since Fri 2025-03-14 14:32:12 UTC; 130ms ago
       Docs: https://docs.mongodb.org/manual
   Main PID: 7710 (mongod)
     Memory: 3.5M (peak: 3.6M)
        CPU: 47ms
     CGroup: /system.slice/mongod.service
             └─7710 /usr/bin/mongod --config /etc/mongod.conf

Mar 14 14:32:12 userver systemd[1]: Started mongod.service - MongoDB Database Server.
```

#### 1.7. Install *mongosh*

`sudo apt install -y mongodb-mongosh`  

> Unfortunately, somehow *mongod.service* keep failing after every attemp to connect via *mongosh*. After trying mutiple solutions and [fixes](https://github.com/nromanen/devops_2025/blob/main/kateryna_kravchuk/task_11/task_11.md#troubleshooting) (none of which worked), I decided to run next steps inside *docker*.  

---

#### 1.x Docker configuration

##### Making a container

To run *Docker container*, install Docker if not already (on [Windows](https://docs.docker.com/desktop/setup/install/windows-install/) host in my case).  
Make [mongosh](https://www.mongodb.com/docs/mongodb-shell/install/) available on the host. Make sure it is installed properly by running `mongosh --version` in cmd / terminal.  
And here is an official [guide](https://www.mongodb.com/docs/manual/tutorial/install-mongodb-community-with-docker/#std-label-docker-mongodb-community-install) to run a **MongoDB** container after that.  

Pull a *docker image* and run a *docker container*:

```bash
docker pull mongodb/mongodb-community-server:latest
docker run --name mongodb -p 27017:27017 -d mongodb/mongodb-community-server:latest
```

Verify successful running by `docker container ls` (shows only this container) or `docker ps -a` (shows the status of **all** available containers):  

```bash
CONTAINER ID   IMAGE                                     COMMAND                  CREATED          STATUS          PORTS                      NAMES
684d81506dbc   mongodb/mongodb-community-server:latest   "python3 /usr/local/…"   45 seconds ago   Up 44 seconds   0.0.0.0:27017->27017/tcp   mongodb
```

##### (Optional) Persistent storage

By default, MongoDB containers lose data when stopped. Use *docker volumes* to store data persistently:  

```bash
# creates a persistent volume
docker volume create mongodb_data

# map the volume to mongidb's data directory
docker run -d --name mongodb -p 27017:27017 -v mongodb_data:/data/db mongo
```

To check the volume: `docker volume inspect mongodb_data`.  

##### Connect

To connect to the MondiDB inside container, use anything from the following:  
    1. `mongosh --port 27017`;  
    2. `mongosh "mongodb://localhost:27017"`;  
    3. `docker exec -it mongodb-container mongosh`.  

> To start a container, use `docker start mongodb`, to stop - `docker stop mongodb`.  

#### 1.8. Verify installation

`mongosh` to open in command line, and `db.version()` to see the iformation about version installed.  

```bash
7.0.17
```

Or run `db.runCommand({ hello: 1 })` for more information:  

**Output**: 

```js
{
  isWritablePrimary: true,
  topologyVersion: {
    processId: ObjectId('67d5557140a2a36ae409c7b5'),
    counter: Long('0')
  },
  maxBsonObjectSize: 16777216,
  maxMessageSizeBytes: 48000000,
  maxWriteBatchSize: 100000,
  localTime: ISODate('2025-03-15T10:25:52.424Z'),
  logicalSessionTimeoutMinutes: 30,
  connectionId: 5,
  minWireVersion: 0,
  maxWireVersion: 21,
  readOnly: false,
  ok: 1
}
```

---

### Task 2: Using MongoDB on VM

> It was **Docker** in my case.  

#### 2.1 Create a database

To create a new DB or to switch if exists: `use lians`.

```bash
switched to db lians
```

> Ceck up after creation: `show dbs`.  

#### 2.2. Add the same documents regarding your favorite books

```js
db.mycol.insertMany( [
    {
        title: 'The Little Prince', 
        author: 'Antoine de Saint-Exupéry', 
        year: '1943', 
        pages: 140, 
        copies: 5000
    },
    {
        title: 'The Three-Body Problem', 
        author: 'Liu Cixin', 
        year: '2014', 
        pages: 390, 
        copies: 1000
    },
    {
        title: 'Confessions', 
        author: 'Jaume Cabré', 
        year: '2015', 
        pages: 760, 
        copies: 3000
    }
] )
```

**Output**:

```js
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId('67d5560d9be32136916b140b'),
    '1': ObjectId('67d5560d9be32136916b140c'),
    '2': ObjectId('67d5560d9be32136916b140d')
  }
}
```

Another way to verify - `show dbs`, where *lians* should have a greater volume that before.  

```bash
admin   40.00 KiB
config  12.00 KiB
lians   40.00 KiB
local   72.00 KiB
```

#### 2.3 Modify the number of copies for one of the books

```js
db.mycol.updateOne({ title: 'The Little Prince' }, { $set: { copies: 8000 } })
```

**Output**:

```js
{
  acknowledged: true,
  insertedId: null,
  matchedCount: 1,
  modifiedCount: 1,
  upsertedCount: 0
}
```

To verify changes: `db.mycol.find().pretty()`.  

**Output**:

```js
[
  {
    _id: ObjectId('67d5560d9be32136916b140b'),
    title: 'The Little Prince',
    author: 'Antoine de Saint-Exupéry',
    year: '1943',
    pages: 140,
    copies: 8000
  },
  {
    _id: ObjectId('67d5560d9be32136916b140c'),
    title: 'The Three-Body Problem',
    author: 'Liu Cixin',
    year: '2014',
    pages: 390,
    copies: 1000
  },
  {
    _id: ObjectId('67d5560d9be32136916b140d'),
    title: 'Confessions',
    author: 'Jaume Cabré',
    year: '2015',
    pages: 760,
    copies: 3000
  }
]
```

#### 2.4 Execute queries to retrieve information

Find all books that have more than 200 pages:  

```js
db.mycol.find({ pages: {$gt: 200} }).pretty()
```

**Output**:

```js
[
  {
    _id: ObjectId('67d5560d9be32136916b140c'),
    title: 'The Three-Body Problem',
    author: 'Liu Cixin',
    year: '2014',
    pages: 390,
    copies: 1000
  },
  {
    _id: ObjectId('67d5560d9be32136916b140d'),
    title: 'Confessions',
    author: 'Jaume Cabré',
    year: '2015',
    pages: 760,
    copies: 3000
  }
]
```

> To exit *mongosh*, type `exit`.

---

## Screenshots

All schreenshots could be found [here](https://drive.google.com/drive/folders/1EbS39UKhvJUjQGdO_CVj6mgX054FQwyJ?usp=sharing).  

### Crucial steps

Creating the database and adding documents to the database: [KillerCoda](https://drive.google.com/file/d/1v5aO02UfDMPaQNpErm69itG393AGP7q4/view?usp=drive_link), [Docker](https://drive.google.com/file/d/1_2bVZZfn2Yayfl9WbwBmmJqa5zsFcivC/view?usp=drive_link).  
Modifying book information: [KillerCoda](https://drive.google.com/file/d/1lcurwq6r_VKvBG32CuwTgRUZk08ab1rI/view?usp=drive_link), [Docker](https://drive.google.com/file/d/1w9jfcu0DSAw4_fSetXBBLiBdVdyheiIu/view?usp=drive_link).  
Executing queries to find books: [KillerCoda](https://drive.google.com/file/d/1L5J3Hd9s9G2XPLp7lLbq7-PKtC4Tns1o/view?usp=drive_link), [Docker](https://drive.google.com/file/d/1YKblK51U2_TetfXBx-T_jkftT3PJnOYU/view?usp=drive_link).  

---

## Troubleshooting

### Version compatability

| Version of MongoDB | Ubuntu Version |
| --- | --- |
| focal | 20.04 |
| jammy  | 22.04 |
| noble | 24.04 |

> Supported [Ubuntu](https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/#platform-support) releases and versions for [another Linux](https://www.mongodb.com/docs/manual/administration/install-on-linux) systems.  

### Failure to keep service running

Example output:  

```bash
× mongod.service - MongoDB Database Server
     Loaded: loaded (/usr/lib/systemd/system/mongod.service; disabled; preset: enabled)
     Active: failed (Result: core-dump) since Fri 2025-03-14 13:36:07 UTC; 23s ago
   Duration: 3.393s
       Docs: https://docs.mongodb.org/manual
    Process: 2687 ExecStart=/usr/bin/mongod --config /etc/mongod.conf (code=dumped, signal=ILL)
   Main PID: 2687 (code=dumped, signal=ILL)
        CPU: 66ms

Mar 14 13:36:04 userver systemd[1]: Started mongod.service - MongoDB Database Server.
Mar 14 13:36:07 userver systemd[1]: mongod.service: Main process exited, code=dumped, status=4/ILL
Mar 14 13:36:07 userver systemd[1]: mongod.service: Failed with result 'core-dump'.
```

If installation or running service fails, it might help to re-install **MongoDb** completely. For deinstallation, use the following commands:  

```bash
sudo service mongod stop
sudo rm -f /etc/apt/sources.list.d/mongodb-org-*.list
sudo apt-get purge mongodb-org*
sudo rm -r /var/log/mongodb
sudo rm -r /var/lib/mongodb
sudo apt autoremove -y
```

### AVX instructions support

MongoDB 7.0+ requires a 64-bit x86-64 CPU with at least SSE4.2 and AVX support. To check if your CPU has the required features, run: `cat /proc/cpuinfo | grep -o -m 1 'sse4_2\|avx'`.  
If *sse4_2* and *avx* appear, your CPU is compatible.  

My output: `sse4_2`, so the virtualization lacks *avx* support, therefore a different solution may be required.  

For information about how to enable *avx* support in VirtualBox, consider to check these links:  

- [Mongod status returns core-dump](https://www.mongodb.com/community/forums/t/mongod-status-returns-core-dump-after-install-v6-on-ubuntu-22-04/207375/4);  
- [Mongo db failed](https://www.mongodb.com/community/forums/t/mongo-db-failed-unable-to-start-mongodb/124039/9);  
- [Attempting fall back to NEM](https://forums.virtualbox.org/viewtopic.php?f=25&t=99390);  
- [Enable AVX and AVX2 instruction sets on Ubuntu](https://forums.virtualbox.org/viewtopic.php?t=106867).  
