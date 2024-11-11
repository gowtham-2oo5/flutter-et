import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../notifiers/expense_notifier.dart';

class QuickAddExpense extends StatelessWidget {
  const QuickAddExpense({super.key});

  Future<void> _openAddExpenseModal(
      BuildContext context, String category) async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    // Check if userId is available
    if (userId == null) {
      print('User ID not found');
      return;
    }

    showModalBottomSheet(
      context: context,
      builder: (_) {
        TextEditingController amountController = TextEditingController();

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Expense for $category',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  prefixIcon: const Icon(Icons.attach_money),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final amount = double.parse(amountController.text);

                    // Call addExpense on ExpenseNotifier to add the expense
                    await Provider.of<ExpenseNotifier>(context, listen: false)
                        .addExpense(userId, category, amount);

                    Navigator.pop(context); // Close the modal
                  } catch (e) {
                    print('Error occurred while adding expense: $e');
                  }
                },
                child: const Text('Add Expense'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Add',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildQuickAddButton(
                context, Icons.fastfood, 'Food', Colors.orange),
            _buildQuickAddButton(
                context, Icons.shopping_cart, 'Shopping', Colors.purple),
            _buildQuickAddButton(
                context, Icons.local_gas_station, 'Transport', Colors.green),
            _buildQuickAddButton(
                context, Icons.more_horiz, 'More', Colors.grey),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickAddButton(
      BuildContext context, IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () => _openAddExpenseModal(context, label),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
