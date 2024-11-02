import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/total_expenses_card.dart';
import '../widgets/quick_add_expense.dart';
import '../widgets/spending_chart.dart';
import '../widgets/recent_transactions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
            onPressed: () {
              // TODO: Navigate to profile screen
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
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
