import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../notifiers/expense_notifier.dart';
import '../models/expense_model.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _selectedFilter = 'All';
  List<String> _filterOptions = ['All', 'This Week', 'This Month', 'This Year'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              setState(() {
                _selectedFilter = result;
              });
            },
            itemBuilder: (BuildContext context) => _filterOptions
                .map((String option) => PopupMenuItem<String>(
                      value: option,
                      child: Text(option),
                    ))
                .toList(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(_selectedFilter),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Consumer<ExpenseNotifier>(
        builder: (context, expenseNotifier, child) {
          List<Expense> filteredTransactions =
              _filterTransactions(expenseNotifier.expenses);

          return filteredTransactions.isEmpty
              ? const Center(child: Text("No transactions found"))
              : ListView.builder(
                  itemCount: filteredTransactions.length,
                  itemBuilder: (context, index) {
                    final transaction = filteredTransactions[index];
                    return _buildTransactionItem(
                      context,
                      icon: _getCategoryIcon(transaction.category),
                      title: transaction.category,
                      amount: '\$${transaction.amount.toStringAsFixed(2)}',
                      date: _formatDate(transaction.date),
                    );
                  },
                );
        },
      ),
    );
  }

  List<Expense> _filterTransactions(List<Expense> transactions) {
    final now = DateTime.now();
    switch (_selectedFilter) {
      case 'This Week':
        return transactions
            .where((t) => t.date.isAfter(now.subtract(const Duration(days: 7))))
            .toList();
      case 'This Month':
        return transactions
            .where((t) => t.date.month == now.month && t.date.year == now.year)
            .toList();
      case 'This Year':
        return transactions.where((t) => t.date.year == now.year).toList();
      default:
        return transactions;
    }
  }

  Widget _buildTransactionItem(BuildContext context,
      {required IconData icon,
      required String title,
      required String amount,
      required String date}) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        // Delete the transaction
        // You need to implement this in your ExpenseNotifier
        // Provider.of<ExpenseNotifier>(context, listen: false).deleteExpense(transaction.id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Theme.of(context).primaryColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'grocery':
        return Icons.shopping_basket;
      case 'transport':
        return Icons.directions_car;
      case 'entertainment':
        return Icons.movie;
      case 'dining':
        return Icons.restaurant;
      default:
        return Icons.attach_money;
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM d, y').format(date);
  }
}
