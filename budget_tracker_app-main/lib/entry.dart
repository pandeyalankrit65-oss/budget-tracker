class Entry {
  final String description;
  final double amount;
  final String? category;
  final DateTime date;

  Entry({required this.description, required this.amount, this.category})
      : date = DateTime.now();

  Map<String, dynamic> toJson() => {
    'description': description,
    'amount': amount,
    'category': category,
    'date': date.toIso8601String(),
  };

  factory Entry.fromJson(Map<String, dynamic> json) => Entry(
    description: json['description'],
    amount: json['amount'],
    category: json['category'],
  );
}