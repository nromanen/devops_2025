const express = require("express");
const app = express();

app.get("/", (req, res) => {
    res.send("I am an endpoint\n");
});

app.listen(3002, () => {
    console.log("App 3 is running on http://localhost:3002\n");
});