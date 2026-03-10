import 'dart:convert';

import 'package:budget_tracker_app/entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveData(List<Entry> incomes, List<Entry> expenses) async {
  final prefs = await SharedPreferences.getInstance();
  final incomeJson = incomes.map((e) => json.encode(e.toJson())).toList();
  final expenseJson = expenses.map((e) => json.encode(e.toJson())).toList();
  await prefs.setStringList('incomes', incomeJson);
  await prefs.setStringList('expenses', expenseJson);
}

Future<(List<Entry>, List<Entry>)> loadData() async {
  final prefs = await SharedPreferences.getInstance();
  final incomeJson = prefs.getStringList('incomes') ?? [];
  final expenseJson = prefs.getStringList('expenses') ?? [];

  final incomes =
      incomeJson.map((e) => Entry.fromJson(json.decode(e))).toList();
  final expenses =
      expenseJson.map((e) => Entry.fromJson(json.decode(e))).toList();
  return (incomes, expenses);
}
