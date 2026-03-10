import 'package:budget_tracker_app/entry.dart';
import 'package:flutter/material.dart';

class AddExpenseWidget extends StatefulWidget {
  final Function onExpenseAdd;
  const AddExpenseWidget({super.key, required this.onExpenseAdd});

  @override
  State<AddExpenseWidget> createState() => _AddExpenseWidgetState();
}

class _AddExpenseWidgetState extends State<AddExpenseWidget> {
  final expenseDesc = TextEditingController();
  final expenseAmount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add Expense', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              controller: expenseDesc,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: expenseAmount,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: const InputDecoration(labelText: 'Category'),
              onChanged: (val) => setState(() => selectedCategory = val!),
              items: categories.map(
                    (cat) => DropdownMenuItem(value: cat, child: Text(cat)),
              ).toList(),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final expenseEntry = Entry(
                    description: expenseDesc.text,
                    amount: double.tryParse(expenseAmount.text) ?? 0,
                    category: selectedCategory,
                  );
                  widget.onExpenseAdd(expenseEntry);
                  expenseDesc.clear();
                  expenseAmount.clear();
                },
                child: const Text('Add Expense'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


String selectedCategory = 'Groceries';

final categories = [
  'Groceries',
  'Bills',
  'Entertainment',
  'Transport',
  'Health',
  'Education'
];