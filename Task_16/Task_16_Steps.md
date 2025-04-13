# Task 16 — Dockerized Web Application

## 👤 Автор:  
Ivan Savytskyy

скріншоти

---

## 📌 Мета завдання:
- Створити контейнеризовану веб-апку, яка виводить **ім’я та прізвище**.
- Взяти готову апку з GitHub.
- Створити Dockerfile, що збирає цю апку.
- Перевірити її роботу у браузері на конкретному порту.
- Надати Dockerfile і скріншоти.

---

## 🔧 Обрана база:
- Docker image: `node:18`

---

## 📁 Структура проєкту:
- 📂 `example-app-nodejs-backend-react-frontend-master/`
  - `src/client/` — React frontend
  - `src/server/` — Express backend
  - `Dockerfile` — створений вручну

---

## 📄 Dockerfile:

```Dockerfile
FROM node:18

WORKDIR /app

COPY . .

RUN npm install && npm install html-webpack-plugin@4.5.2 --save-dev

RUN NODE_OPTIONS=--openssl-legacy-provider npm run build

EXPOSE 3000

CMD ["npm", "start"]


# Створення Docker образу
sudo docker build -t ivan-node-app .

# Запуск контейнера
sudo docker run -d -p 8082:3000 --name ivan-node-container ivan-node-app

У браузері при відкритті http://localhost:8082
відображається:

Welcome to Ivan Savytskyy Project