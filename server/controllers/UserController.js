const User = require("../models/UserModel"); // Adjust the path as needed
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken"); // For generating tokens

// Register a new user
const registerUser = async (req, res) => {
  console.log("Request received");
  const { name, email, password } = req.body; // Destructure username, email, and password from req.body

  try {
    // Check if the user already exists
    const existingUser = await User.findOne({ email }); // Correctly check if a user exists by email
    if (existingUser) {
      return res.status(400).json({ message: "User already exists" });
    }

    // Hash the password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Create a new user instance
    const user = new User({ name, email, password: hashedPassword });
    await user.save(); // Save the new user to the database
    console.log("User saved");
    res.status(201).json({ message: "User registered successfully" });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Authenticate a user and return a token
const loginUser = async (req, res) => {
  const { email, password } = req.body;
  console.log(email);
  console.log(password);

  try {
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(401).json({ message: "Invalid credentials" });
    }

    const isMatch = await bcrypt.compare(password, user.password);
    console.log(isMatch); // Compare hashed passwords
    if (!isMatch) {
      return res.status(401).json({ message: "Invalid credentials" });
    }

    res.status(200).json({ user });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Get user profile
const getUserProfile = async (req, res) => {
  const { userId } = req.params;

  try {
    const user = await User.findById(userId).select("-password"); // Exclude password from the response
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    res.status(200).json(user);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Get all users
const getAllUsers = async (req, res) => {
  try {
    const users = await User.find(); // Await the User.find() call
    res.status(200).json({ users });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

const deleteUser = async (req, res) => {
  const { userId } = req.params;

  try {
    const user = await User.findById(userId); // Exclude password from the response
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }
    await user.deleteOne();
    return res.status(200).json({ message: "User Deleted" });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Export the methods
module.exports = {
  registerUser,
  loginUser,
  getUserProfile,
  getAllUsers,
  deleteUser,
};
