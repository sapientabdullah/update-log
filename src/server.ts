import express from "express";
import path from "path";

const app = express();

app.get("/", (req, res) => {
  console.log("res");
});

export default app;
