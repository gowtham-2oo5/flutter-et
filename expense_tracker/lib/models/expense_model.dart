class Expense {
  final String id;
  final String userId;
  final String category;
  final double amount;
  final String? description;
  final DateTime date;

  Expense({
    required this.id,
    required this.userId,
    required this.category,
    required this.amount,
    this.description,
    required this.date,
  });

  // Factory method to create Expense from JSON
  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      category: json['category'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }

  // Method to convert Expense to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'category': category,
      'amount': amount,
      'description': description,
      'date': date.toIso8601String(),
    };
  }
}
