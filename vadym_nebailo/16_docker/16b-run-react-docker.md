#### 1. Dockerfile
```
FROM node:20-slim AS frontend-builder

WORKDIR /app

COPY src/client ./src/client
COPY package*.json ./
COPY webpack.config.js ./

ENV NODE_OPTIONS=--openssl-legacy-provider

RUN npm install && npm run build

#--------------------------  
FROM node:20-slim

WORKDIR /app

COPY src/server ./src/server
COPY package*.json ./
COPY --from=frontend-builder /app/static ./static

RUN npm install --omit=dev

EXPOSE 3000

CMD ["npm", "start"]
```

#### 2. Screenshot
https://drive.google.com/file/d/1GRxqexyScZWGhS_4yqPvq_gYrU3XoAmh/view?usp=sharing