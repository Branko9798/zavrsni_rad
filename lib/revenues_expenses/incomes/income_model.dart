import 'dart:ffi';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:zavrsni_rad/database/database.dart';
import 'package:zavrsni_rad/main.dart';
import 'package:zavrsni_rad/revenues_expenses/incomes/income.dart';

class IncomeModel {
  final db = getIt<AppDatabase>();
  final incomes = ValueNotifier<List<Income>>([]);

  Stream<List<Income>> get allIncomesStream => db.incomesTable.all().watch();

  Stream<List<Income>> filteredIncomes(List<String> categories) {
    return (db.incomesTable.select()
          ..where((tbl) => tbl.incomeCategoryId.isIn(categories)))
        .watch();
  }

  void addIncome(Income income) async {
    var newValue = incomes.value..add(income);
    await db.incomesTable.insert().insert(income);
    incomes.value = newValue;
  }
}
