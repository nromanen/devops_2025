FROM node:18

WORKDIR /app

COPY . .

RUN npm install && npm install html-webpack-plugin@4.5.2 --save-dev

RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]
