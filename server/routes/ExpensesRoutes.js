const express = require("express");
const router = express.Router();
const {
  createExpense,
  deleteExpense,
  getUserExpenses,
  updateExpense,
  getAllExpenses,
} = require("../controllers/ExpenseController"); // Adjust the path as needed

// Define routes
router.post("/create-expense", createExpense);
router.delete("/delete-expense/:id", deleteExpense);
router.get("/getUserExpense/:userId", getUserExpenses);
router.get("/get-all", getAllExpenses);
router.put("/update-expense/:id", updateExpense);

module.exports = router;
