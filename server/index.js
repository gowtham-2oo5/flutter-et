const express = require("express");
const mongoose = require("mongoose");
require("dotenv").config();
const bodyParser = require("body-parser");
const PORT = process.env.PORT || 3000;

const expRouter = require("./routes/ExpensesRoutes");
const userRouter = require("./routes/UserRoutes");

mongoose
  .connect(process.env.MONGO_URL)
  .then(() => {
    console.log("Connected to DB Successfully");
  })
  .catch((err) => {
    console.error(err);
  });

const app = express();
app.use(bodyParser.json());

app.listen(PORT, () => {
  console.log(`Server running on port http://localhost:${PORT}`);
});

app.get("/", (req, res) => {
  res.json({
    Message: "Hello world",
  });
});

app.use("/api/v1/exp", expRouter);
app.use("/api/v1/usr", userRouter);
