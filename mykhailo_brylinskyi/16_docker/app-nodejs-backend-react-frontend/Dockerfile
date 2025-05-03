FROM node:18

WORKDIR /app

COPY . ./

ENV NODE_OPTIONS=--openssl-legacy-provider

RUN npm install
RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]
