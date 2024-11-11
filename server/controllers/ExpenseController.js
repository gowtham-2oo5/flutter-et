const Expenses = require("../models/ExpenseModel"); // Adjust the path as needed
const User = require("../models/UserModel"); // Assuming you have a User model

// Create a new expense
const createExpense = async (req, res) => {
  const { userId, category, amount, description, date } = req.body;
  console.log("Creating expense for user", userId);
  console.log("Category:", category);

  try {
    // Check if user exists
    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    const expense = new Expenses({
      userId,
      category,
      amount,
      description,
      date,
    });

    await expense.save();
    res.status(201).json(expense);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Get all expenses for a user
const getUserExpenses = async (req, res) => {
  const { userId } = req.params;

  try {
    // Check if the user exists
    console.log("Checking user with id", userId);
    const user = await User.findById(userId); // Await the promise
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    // If the user exists, fetch their expenses
    const expenses = await Expenses.find({ userId });
    res.status(200).json(expenses);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Update an expense
const updateExpense = async (req, res) => {
  const { expenseId } = req.params;
  const updates = req.body;

  try {
    const expense = await Expenses.findByIdAndUpdate(expenseId, updates, {
      new: true, // Return the updated document
      runValidators: true, // Validate before updating
    });

    if (!expense) {
      return res.status(404).json({ message: "Expense not found" });
    }

    res.status(200).json(expense);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Delete an expense
const deleteExpense = async (req, res) => {
  const { id } = req.params;

  try {
    const expense = await Expenses.findByIdAndDelete(id);

    if (!expense) {
      return res.status(404).json({ message: "Expense not found" });
    }

    res.status(204).json({ Message: "Delete aindhi" }); // No content
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const getAllExpenses = async (req, res) => {
  try {
    // Fetch all expenses from the database
    const expenses = await Expenses.find();

    // Check if there are any expenses
    if (expenses.length === 0) {
      return res.status(404).json({ message: "No expenses found" });
    }

    // Respond with the list of expenses
    res.status(200).json(expenses);
  } catch (error) {
    // Handle any errors that occur during the request
    res.status(500).json({ message: error.message });
  }
};

// Export the methods
module.exports = {
  createExpense,
  getUserExpenses,
  updateExpense,
  deleteExpense,
  getAllExpenses,
};
