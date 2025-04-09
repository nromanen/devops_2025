# Stage 1: Build frontend
FROM node:16 AS build-frontend

WORKDIR /app

COPY package*.json ./
COPY src/client/ ./src/client/
COPY webpack.config.js ./

RUN npm install
RUN npm run build


FROM node:16

WORKDIR /app


COPY src/server/ ./src/server/


COPY --from=build-frontend /app/static ./static

COPY package*.json ./
RUN npm install

EXPOSE 3000

CMD ["node", "src/server/app.js"]
