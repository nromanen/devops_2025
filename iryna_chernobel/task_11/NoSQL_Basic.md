
# Task 11: NoSQL


# KillerCoda середовища

- Запусти середовище на KillerCoda, перейшовши за посиланням:
👉 [Setup MongoDB на KillerCoda](https://killercoda.com/online-marathon/course/DevOps_dev/Setup_mongodb)


- На останньому кроці створіть базу даних із власним ім’ям замість john_doe.

### 1. Створення бази даних
``` 
use iryna_ch

``` 
[Result](https://drive.google.com/file/d/1ZZ1TA0waMBb9DO7VgwN_rc-sQb3E6Hcr/view?usp=drive_link)

### 2. Додавання документів (книг). Введені книги містять поля: `title`,` author`, `year`, `pages`,` copies`, `publisher`.

- Перша книга
``` 
db.books.insertOne({
  title: "The Little Prince",
  author: "Antoine de Saint-Exupéry",
  year: 1943,
  pages: 96,
  copies: 4,
  publisher: "Reynal & Hitchcock"
})
``` 
- Додано ще дві книги:
``` 
db.books.insertMany([
  {
    title: "The Great Gatsby",
    author: "F. Scott Fitzgerald",
    year: 1925,
    pages: 218,
    copies: 6,
    publisher: "Charles Scribner's Sons"
  },
  {
    title: "Romeo and Juliet",
    author: "William Shakespeare",
    year: 1597,
    pages: 142,
    copies: 5,
    publisher: "Thomas Creede"
  }
])
``` 
[Results](https://drive.google.com/drive/folders/1mVee_4wJavC9sf-Dui7TixkcAonyurVn?usp=drive_link)

### 3. Оновлення інформації про книгу.
Змінено кількість примірників для The Little Prince:
``` 
db.books.updateOne(
  { title: "The Little Prince" },
  { $set: { copies: 1 } }
)

``` 
[Result](https://drive.google.com/file/d/1dsOFod_EfcPui2si0kTTrJKz7q7Yz_OK/view?usp=drive_link)

### 4. Запит: знайти всі книги, видані в тому ж році, що й одна з раніше доданих
``` 
iryna_ch> db.books.find({ year: 1597 }).pretty()

``` 
[Result](https://drive.google.com/file/d/16qWmrxyRpaqHeMkSR32jM_cWJbBDqlpO/view?usp=drive_link)

# Встановлення MongoDB на VirtualBox Ubuntu 22.04

Для розгортання MongoDB я використала Docker та Docker Compose

### 1. Встановлення Docker Compose
``` 
sudo apt install docker-compose
``` 

### 2. Створення проєктної папки
``` 
mkdir mongo
cd mongo
``` 

### 3. Створення файлу docker-compose.yml

``` 
nano docker-compose.yml

``` 

- Пошук офіційного образу MongoDB на Docker Hub

``` 
version: '3.1'

services:
  mongo:
    image: mongo:4.4
    restart: always
    environment:
      MONGO_INITDB_ROOT_USERNAME: root
      MONGO_INITDB_ROOT_PASSWORD: example

  mongo-express:
    image: mongo-express
    restart: always
    ports:
      - 8081:8081
    environment:
      ME_CONFIG_MONGODB_ADMINUSERNAME: root
      ME_CONFIG_MONGODB_ADMINPASSWORD: example
      ME_CONFIG_MONGODB_URL: mongodb://root:example@mongo:27017/
      ME_CONFIG_BASICAUTH: "false"
 ``` 
      
- Я використала образ mongo: 4.4, оскільки новіші версії MongoDB вимагають підтримки AVX, якої немає на моїй віртуальній машині.

### 4. Запуск MongoDB
``` 
sudo docker-compose up -d
``` 
### 5. Перевірка роботи MongoDB
``` 
docker ps
``` 
- Підключилась до MongoDB Shell
``` 
docker exec -it mongo_mongo_1 mongo -u root -p example --authenticationDatabase admin

``` 
## 6. Виконуйте ті самі завдання у вашому локальному середовищі, що й на KillerCoda:

- [x] Створіть базу даних

- [x] Додайте такі самі документи щодо ваших улюблених книг

- [x] Змініть кількість примірників однієї з книг

- [x] Виконуйте запити для отримання інформації

Screanshot: https://drive.google.com/drive/folders/1-q-DY1CZDgCSyFhFd30gx2qvT7ZFlbip?usp=drive_link


