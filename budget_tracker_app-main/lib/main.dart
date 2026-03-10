import 'package:budget_tracker_app/add_expense_widget.dart';
import 'package:budget_tracker_app/add_income_widget.dart';
import 'package:budget_tracker_app/entry.dart';
import 'package:budget_tracker_app/storage_util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Entry> incomes = [];
  List<Entry> expenses = [];

  @override
  void initState() {
    super.initState();
    loadData().then((value) {
      incomes = value.$1;
      expenses = value.$2;
      setState(() {});
    });
  }

  double get totalIncome => incomes.fold(0, (sum, item) => sum + item.amount);

  double get totalExpense => expenses.fold(0, (sum, item) => sum + item.amount);

  Map<String, double> get categoryBreakdown {
    Map<String, double> map = {for (var cat in categories) cat: 0};
    for (var e in expenses) {
      if (e.category != null) map[e.category!] = map[e.category!]! + e.amount;
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Budget Tracker')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AddIncomeWidget(onAdd: (entry) {
              incomes.add(entry);
              saveData(incomes, expenses);
              setState(() {});
            }),
            const SizedBox(height: 20),
            AddExpenseWidget(onExpenseAdd: (entry) {
              expenses.add(entry);
              saveData(incomes, expenses);
              setState(() {});
            }),
            const SizedBox(height: 30),
            const Text(
              'Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Total Income: ₹${totalIncome.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16)),
            Text('Total Expenses: ₹${totalExpense.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text(
              'Expenses by Category:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            ...categoryBreakdown.entries.map(
                  (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text('${e.key}: ₹${e.value.toStringAsFixed(2)}'),
              ),
            ),
          ],
        ),
      )
    );
  }
}
