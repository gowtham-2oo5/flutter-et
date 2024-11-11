import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../notifiers/expense_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TotalExpensesCard extends StatefulWidget {
  const TotalExpensesCard({Key? key}) : super(key: key);

  @override
  _TotalExpensesCardState createState() => _TotalExpensesCardState();
}

class _TotalExpensesCardState extends State<TotalExpensesCard> {
  late String userId;
  bool isLoading = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId') ?? '';
    setState(() {
      isLoading = false;
    });
    _startPeriodicFetch();
  }

  void _startPeriodicFetch() {
    // Fetch immediately
    _fetchData();
    // Then set up a timer to fetch every 30 seconds
    _timer = Timer.periodic(const Duration(seconds: 30), (_) => _fetchData());
  }

  Future<void> _fetchData() async {
    if (!mounted) return;
    final expenseNotifier =
        Provider.of<ExpenseNotifier>(context, listen: false);
    await expenseNotifier.fetchTotalExpenses(userId);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Consumer<ExpenseNotifier>(
      builder: (context, expenseNotifier, child) {
        double expensePercentage = expenseNotifier.monthlyBudget > 0
            ? expenseNotifier.totalExpenses / expenseNotifier.monthlyBudget
            : 0;

        return Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[700]!, Colors.blue[500]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Expenses',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    Icon(Icons.account_balance_wallet,
                        color: Colors.white.withOpacity(0.9)),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  '\$${expenseNotifier.totalExpenses.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: expensePercentage,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      expensePercentage > 0.9 ? Colors.red : Colors.white,
                    ),
                    minHeight: 10,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${(expensePercentage * 100).toStringAsFixed(0)}% of monthly budget',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
