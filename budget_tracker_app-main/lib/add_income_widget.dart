import 'package:budget_tracker_app/entry.dart';
import 'package:flutter/material.dart';

class AddIncomeWidget extends StatefulWidget {
  final Function onAdd;
  const AddIncomeWidget({super.key, required this.onAdd});

  @override
  State<AddIncomeWidget> createState() => _AddIncomeWidgetState();
}

class _AddIncomeWidgetState extends State<AddIncomeWidget> {
  final incomeDesc = TextEditingController();
  final incomeAmount = TextEditingController();

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
            const Text('Add Income', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              controller: incomeDesc,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: incomeAmount,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onAdd(Entry(
                      description: incomeDesc.text,
                      amount: double.tryParse(incomeAmount.text) ?? 0));
                  incomeDesc.clear();
                  incomeAmount.clear();
                },
                child: const Text('Add Income'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
