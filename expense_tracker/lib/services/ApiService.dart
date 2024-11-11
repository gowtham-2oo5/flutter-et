import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../models/expense_model.dart';

class ApiService {
  // Define the base URL
  static const String baseUrl = 'http://127.0.0.1:3000/api/v1';

  // User-related endpoints

  // Register a new user
  Future<http.Response> registerUser(Map<String, dynamic> userData) async {
    final url = Uri.parse('$baseUrl/usr/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userData),
    );
    return response;
  }

  // Log in a user
  Future<http.Response> loginUser(Map<String, dynamic> loginData) async {
    final url = Uri.parse('$baseUrl/usr/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(loginData),
    );
    return response;
  }

  // Get a user's profile by userId
  Future<User> getUserProfile(String userId) async {
    final url = Uri.parse('$baseUrl/usr/profile/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  // Get all users
  Future<List<User>> getAllUsers() async {
    final url = Uri.parse('$baseUrl/usr/get-all');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> userList = json.decode(response.body);
      return userList.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  // Expense-related endpoints

  // Get expenses for a specific user by userId
  Future<List<Expense>> getUserExpenses(String userId) async {
    final url = Uri.parse('$baseUrl/exp/getUserExpense/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> expenseList = json.decode(response.body);
      return expenseList.map((json) => Expense.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load user expenses');
    }
  }

  // Get all expenses
  Future<List<Expense>> getAllExpenses() async {
    final url = Uri.parse('$baseUrl/exp/get-all');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> expenseList = json.decode(response.body);
      return expenseList.map((json) => Expense.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load expenses');
    }
  }

  // Create a new expense
  Future<http.Response> createExpense(Map<String, dynamic> expenseData) async {
    final url = Uri.parse('$baseUrl/exp/create-expense');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(expenseData),
    );
    return response;
  }

  // Delete an expense by ID
  Future<http.Response> deleteExpense(String expenseId) async {
    final url = Uri.parse('$baseUrl/exp/delete-expense/$expenseId');
    final response = await http.delete(url);
    return response;
  }

  // Update an expense by ID
  Future<http.Response> updateExpense(
      String expenseId, Map<String, dynamic> expenseData) async {
    final url = Uri.parse('$baseUrl/exp/update-expense/$expenseId');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(expenseData),
    );
    return response;
  }
}
