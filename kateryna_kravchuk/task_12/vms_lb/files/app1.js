const express = require("express");
const app = express();

app.get("/", (req, res) => {
    res.send("I am an endpoint\n");
});

app.listen(3000, () => {
    console.log("App 1 is running on http://localhost:3000\n");
});