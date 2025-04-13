FROM node:22-alpine

WORKDIR /app

COPY . .

# Install dependencies
RUN npm install 

# Webpack
ENV NODE_OPTIONS=--openssl-legacy-provider
RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]
