import 'package:flutter/material.dart';

class QuickAddExpense extends StatelessWidget {
  const QuickAddExpense({Key? key}) : super(key: key);

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
            _buildQuickAddButton(Icons.fastfood, 'Food', Colors.orange),
            _buildQuickAddButton(
                Icons.shopping_cart, 'Shopping', Colors.purple),
            _buildQuickAddButton(
                Icons.local_gas_station, 'Transport', Colors.green),
            _buildQuickAddButton(Icons.more_horiz, 'More', Colors.grey),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickAddButton(IconData icon, String label, Color color) {
    return Column(
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
    );
  }
}
