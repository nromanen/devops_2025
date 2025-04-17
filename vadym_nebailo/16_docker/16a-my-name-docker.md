#### 1. Dockerfile
```
FROM node:20-alpine

EXPOSE 3000
  
WORKDIR /usr/src/app

COPY package.json package-lock.json* ./ 

RUN npm install && npm cache clean --force

COPY . .

CMD ["npm", "start"]
```

#### 2. APP.JS
```js
const http = require('http');

const hostname = '0.0.0.0';
const port = 3000;
 
const server = http.createServer((req, res) => {
	res.statusCode = 200;
	res.setHeader('Content-Type', 'text/plain');
	res.end('Vadym Nedbailo');
}); 

server.listen(port, hostname, () => {
	console.log(`Server running at http://${hostname}:${port}/`);
});
```

#### 3. PACKAGE.JSON
```
{
	"name": "node-web-app",
	"version": "1.0.0",
	"main": "app.js",
	"scripts": {
		"start": "node app.js"
	}
}
```

#### 4. Running application in Docker
```bash
//build image
docker build -t my-name-docker .

//run container
docker run -d -p 3000:3000 my-name-docker
```

#### 5. Screenshot
https://drive.google.com/file/d/1XyvLQ8Xx6vNFRxYguEByOUmuIRPynWeM/view?usp=sharing