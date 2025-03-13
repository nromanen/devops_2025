### [GD task 11](https://drive.google.com/drive/folders/1vqlHQ009dVeQtqt49MXVkL11QPXkFZpF?usp=drive_link)

- [x] Launch the environment on KillerCoda by visiting https://killercoda.com/online-marathon/course/DevOps_dev/Setup_mongodb and follow all the provided steps

- [x] In the last step, create a database named <your name> instead of john_doe
  - [create db by my name](https://drive.google.com/file/d/13xq-CzLnGBaOpxbpYCWhDvsqE7DuN9dp/view?usp=sharing)
  - `use denys_fv`

- [x] Add three documents to the database that include the following details about your favorite books: Title, Author, Year of Publication, Number of Pages, Number of Copies
  - [add three doc](https://drive.google.com/file/d/1yoMOU0B3SCDnwwd937Zri4ke-MLZZhqO/view?usp=sharing)
  - `db.books.insertMany([{},{}])`

- [x] Update book information: modify the number of copies for the first book you entered
  - [change count copies](https://drive.google.com/file/d/1VIGLofiGvnQCqlGDe3U3_xgAZ_71i4MZ/view?usp=sharing)
  - `db.books.update({'copies': '10000'},{$set:{'copies':'520'}})`

- [x] Query for books: find all books published in the same year as one of the books you entered
  - [find by same publish](https://drive.google.com/file/d/1F7FNf7BYRPknBe2K9__TVO5QyST-8w2f/view?usp=sharing)
  -`db.books.find({publish: '2025'}).pretty()`

- [x] Install MongoDB on your previously created virtual machine with Linux
  - `wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -`
  - `echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list`
  - `sudo apt-get update`
  - if you'll take misstake about Depends, when do it:
    - ```wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_amd64.deb --2025-03-13 07:42:57--  http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_amd64.deb``` 
    - `sudo dpkg -i libssl1.1_1.1.0g-2ubuntu4_amd64.deb`
  - `mongod --version`
  - `sudo systemctl start mongod` and `sudo systemctl status mongod`
 
- [x] Perform the same tasks in your local environment as you did on KillerCoda:
  - Create a database
  - Add the same documents regarding your favorite books
  - Modify the number of copies for one of the books
  - Execute queries to retrieve information

- [x] Create and provide screenshots that clearly demonstrate each step of your process for both KillerCoda and your local environment, including:
  - [Creating the database](https://drive.google.com/file/d/13xq-CzLnGBaOpxbpYCWhDvsqE7DuN9dp/view?usp=drive_link)
  - [Adding documents to the database](https://drive.google.com/file/d/1yoMOU0B3SCDnwwd937Zri4ke-MLZZhqO/view?usp=drive_link)
  - [Modifying book information](https://drive.google.com/file/d/1VIGLofiGvnQCqlGDe3U3_xgAZ_71i4MZ/view?usp=drive_link)
  - [Executing queries to find books](https://drive.google.com/file/d/1F7FNf7BYRPknBe2K9__TVO5QyST-8w2f/view?usp=drive_link) 
