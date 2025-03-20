###### 1.Create a database
```bash
test> use vadym
switched to db vadym
vadym> 
```
[//]: screenshot
https://drive.google.com/file/d/1q_6F0o9UD-tehPBs4jIVbpcNqwtM4YNR/view?usp=sharing
###### 2. Add the same documents regarding your favorite books

```bash
db.books.insertMany([
  {
    title: "Книга Моральні листи до Луцілія",
    author: "Сенека",
    year_of_publication: 2019,
    number_of_pages: 218,
    number_of_copies: 1000
  },
  {
    title: "Червоне і Чорне",
    author: "Стендаль",
    year_of_publication: 2015,
    number_of_pages: 519,
    number_of_copies: 1500
  },
  {
    title: "1984",
    author: "Джордж Орвел",
    year_of_publication: 2013,
    number_of_pages: 328,
    number_of_copies: 1000
  }
])
```
[//]: screenshot
https://drive.google.com/file/d/1s-dK6Dr5PCftd0YYuKcTBN7G7p6Qf6Iu/view?usp=sharing
###### 3. Update book information: modify the number of copies for the first book you entered
```bash
vadym> db.books.updateOne(
...   { title: "Книга Моральні листи до Луцілія" },
...   { $set: { number_of_copies: 500 } }
... )

vadym> db.books.find().pretty()
[
  {
    _id: ObjectId('67d94e04d288cbd0636b140b'),
    title: 'Книга Моральні листи до Луцілія',
    author: 'Сенека',
    year_of_publication: 2019,
    number_of_pages: 218,
    number_of_copies: 500
  },
  {
    _id: ObjectId('67d94e04d288cbd0636b140c'),
    title: 'Червоне і Чорне',
    author: 'Стендаль',
    year_of_publication: 2015,
    number_of_pages: 519,
    number_of_copies: 1500
  },
  {
    _id: ObjectId('67d94e04d288cbd0636b140d'),
    title: '1984',
    author: 'Джордж Орвел',
    year_of_publication: 2013,
    number_of_pages: 328,
    number_of_copies: 1000
  }
]
vadym> 
```
[//]: screenshot
https://drive.google.com/file/d/1Hwwiwr6U2MnmP-MPjSUuQfwXcFz8z_lc/view?usp=sharing
###### 4. Query for books: find all books published in the same year as one of the books you entered
```bash
vadym> db.books.find({ "year_of_publication": 2019 })
[
  {
    _id: ObjectId('67d94e04d288cbd0636b140b'),
    title: 'Книга Моральні листи до Луцілія',
    author: 'Сенека',
    year_of_publication: 2019,
    number_of_pages: 218,
    number_of_copies: 500
  }
]
vadym> 

```
[//]: screenshot
https://drive.google.com/file/d/1U1VpL5XTVhgpRnDcXWDQbk-wWHZdSmmi/view?usp=sharing