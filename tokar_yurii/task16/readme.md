

IMG

[console] - https://drive.google.com/file/d/15k3cMRDceIl2ZV-368allRWb1fwm2tW3/view?usp=sharing
[result] - https://drive.google.com/file/d/1AqBqn72j6a9_noZJmjjS3Ox6ukGRqSYt/view?usp=sharing

--- 
---

```js
const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('<h1>hello, Yurii Tokar</h1>');
});

app.listen(port, () => {
  console.log(`App running at http://localhost:${port}`);
});
```



``` Dockerfile

FROM node:22

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000

CMD ["node", "index.js"]
```
---

BUild 

```
docker build -t app .
```

Run
```
docker run -p 3000:3000 app
```

