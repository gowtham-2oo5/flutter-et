const mongoose = require("mongoose");
const bcrypt = require("bcrypt"); // For password hashing

const userSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
      trim: true,
    },
    email: {
      type: String,
      required: true,
      unique: true, // Ensure unique emails
      trim: true,
      lowercase: true, // Store emails in lowercase
    },
    password: {
      type: String,
      required: true,
      minlength: 6, // Minimum password length
    },
    createdAt: {
      type: Date,
      default: Date.now,
    },
    updatedAt: {
      type: Date,
      default: Date.now,
    },
  },
  { timestamps: true } // Automatically manage createdAt and updatedAt fields
);

const User = mongoose.model("User", userSchema);

module.exports = User;
