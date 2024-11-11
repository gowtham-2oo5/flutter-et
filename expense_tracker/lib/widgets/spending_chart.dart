import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../models/expense_model.dart';
import '../notifiers/expense_notifier.dart';

class SpendingChart extends StatelessWidget {
  const SpendingChart({super.key});

  List<PieChartSectionData> _generateChartSections(List<Expense> expenses) {
    Map<String, double> categoryTotals = {};
    double total = 0;

    for (var expense in expenses) {
      categoryTotals[expense.category] =
          (categoryTotals[expense.category] ?? 0) + expense.amount;
      total += expense.amount;
    }

    List<Color> colors = [
      Colors.blue[400]!,
      Colors.green[400]!,
      Colors.red[400]!,
      Colors.orange[400]!,
      Colors.purple[400]!,
      Colors.teal[400]!,
    ];

    return categoryTotals.entries.map((entry) {
      int colorIndex =
          categoryTotals.keys.toList().indexOf(entry.key) % colors.length;
      double percentage = (entry.value / total) * 100;
      return PieChartSectionData(
        color: colors[colorIndex],
        value: entry.value,
        title: '${percentage.toStringAsFixed(1)}%',
        radius: 60 + (percentage * 0.5),
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseNotifier>(
      builder: (context, expenseNotifier, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Spending Analytics',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: expenseNotifier.expenses.isEmpty
                    ? const Center(child: Text('No expense data available'))
                    : PieChart(
                        PieChartData(
                          sections:
                              _generateChartSections(expenseNotifier.expenses),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                          startDegreeOffset: -90,
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
