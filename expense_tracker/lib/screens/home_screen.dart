import 'package:expense_tracker/services/ApiService.dart';
import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
import '../widgets/total_expenses_card.dart';
import '../widgets/quick_add_expense.dart';
import '../widgets/spending_chart.dart';
import '../widgets/recent_transactions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense_tracker/services/ApiService.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            icon: const CircleAvatar(
              backgroundImage: AssetImage("assets/dp.png"),
            ),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              String? userId = prefs.getString('userId');
              print(userId);
              // TODO: Navigate to profile screen
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TotalExpensesCard(),
              SizedBox(height: 24),
              QuickAddExpense(),
              SizedBox(height: 24),
              SpendingChart(),
              SizedBox(height: 24),
              RecentTransactions(),
            ],
          ),
        ),
      ),
    );
  }
}
