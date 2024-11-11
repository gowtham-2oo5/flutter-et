import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/foundation.dart';
import '../services/ApiService.dart';

class ExpenseNotifier extends ChangeNotifier {
  double totalExpenses = 0.0;
  final double monthlyBudget = 5000.0;

  List<Expense> expenses = [];

  bool isLoading = true;

  // Fetch the total expenses for a specific user
  Future<void> fetchTotalExpenses(String userId) async {
    try {
      print("fetching expenses for user $userId");
      final expensesList = await ApiService().getUserExpenses(userId);
      expenses = expensesList; // Update the expenses list
      totalExpenses = expenses.fold(0, (sum, expense) => sum + expense.amount);
      print("done fetching");
      isLoading = false;
      notifyListeners(); // Notify listeners about the changes
    } catch (e) {
      print('Failed to fetch expenses: $e');
    }
  }

  // Add a new expense
  Future<void> addExpense(String userId, String category, double amount) async {
    try {
      final expenseData = {
        'userId': userId,
        'category': category,
        'amount': amount,
      };

      // Call the ApiService to create the new expense
      final newExpense = await ApiService().createExpense(expenseData);

      // Update the expenses list and total expenses
      expenses.add(newExpense); // Add the new expense to the list
      totalExpenses += newExpense.amount; // Update the total expenses

      notifyListeners(); // Notify listeners immediately
    } catch (e) {
      print('Failed to add expense: $e');
    }
  }
}
