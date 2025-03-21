const express = require("express");
const app = express();

app.get("/", (req, res) => {
    res.send("I am an endpoint\n");
});

app.listen(3001, () => {
    console.log("App 2 is running on http://localhost:3001\n");
});