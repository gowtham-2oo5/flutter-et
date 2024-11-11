const mongoose = require("mongoose");

const expensesSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      required: true,
      ref: "User", // Assuming you have a User model
    },
    category: {
      type: String,
      enum: [
        "Housing",
        "Food",
        "Transport",
        "Dining",
        "Utilities",
        "Entertainment",
        "Shopping",
        "Others",
      ],
      required: true,
    },
    amount: {
      type: Number,
      required: true,
      min: 0, // Ensures the amount is not negative
    },
    description: {
      type: String,
      trim: true, // Removes whitespace from both ends
    },
    date: {
      type: Date,
      required: true,
      default: Date.now, // Sets the default date to now
    },
  },
  { timestamps: true }
);

const Expenses = mongoose.model("Expenses", expensesSchema);

module.exports = Expenses;
