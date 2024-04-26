import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:zavrsni_rad/database/database.dart';
import 'package:zavrsni_rad/main.dart';
import 'package:zavrsni_rad/revenues_expenses/expenses/expenses.dart';

class ExpensesModel {
  final db = getIt<AppDatabase>();

  final expenses = ValueNotifier<List<Expense>>([]);

  Stream<List<Expense>> get allExpensesStream => db.expensesTable.all().watch();

  Stream<List<Expense>> filteredStream(String categoryID) {
    return allExpensesStream.map((expenses) => expenses
        .where((element) => element.category?.id == categoryID)
        .toList());
  }

  void addExpense(Expense expense) async {
    var newValue = expenses.value..add(expense);
    await db.expensesTable.insert().insert(expense);
    expenses.value = newValue;
  }
}
