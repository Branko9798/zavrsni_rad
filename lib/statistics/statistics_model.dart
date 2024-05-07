import 'package:drift/drift.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:zavrsni_rad/database/database.dart';
import 'package:zavrsni_rad/main.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:zavrsni_rad/revenues_expenses/expenses/expense_category.dart';
import 'package:zavrsni_rad/revenues_expenses/expenses/expenses.dart';
import 'package:zavrsni_rad/revenues_expenses/incomes/income_category.dart';

class StatisticsModel {
  final db = getIt<AppDatabase>();

  Stream<double> incomesTotal() {
    final incomeSum = db.incomesTable.incomeValue.sum();

    return db.incomesTable
        .select()
        .addColumns([incomeSum])
        .map((p0) => p0.read(incomeSum))
        .watchSingle()
        .map((event) {
          if (event == null) {
            return 0;
          } else {
            return event;
          }
        });
  }

  Stream<double> expensesTotal() {
    final expensesSum = db.expensesTable.expenseValue.sum();

    return db.expensesTable
        .select()
        .addColumns([expensesSum])
        .map((p0) => p0.read(expensesSum))
        .watchSingle()
        .map((event) {
          if (event == null) {
            return 0;
          } else {
            return event;
          }
        });
  }

  Stream<double> total() {
    return incomesTotal().combineLatest(expensesTotal(), (p0, p1) => p0 - p1);
  }

  Stream<PieChartData> expensesByCategory() {
    return db.expensesTable.all().watch().map((expenses) {
      var expensesTotalByCategory = <ExpenseCategory, double>{};

      for (var expense in expenses) {
        if (expense.category == null) {
          continue;
        }

        if (expensesTotalByCategory[expense.category!] == null) {
          expensesTotalByCategory[expense.category!] = 0.0;
        }
        expensesTotalByCategory[expense.category!] =
            expensesTotalByCategory[expense.category!]! + expense.expenseValue;
      }

      final sectionData = expensesTotalByCategory.entries.map(
        (entry) {
          final key = entry.key;
          final value = entry.value;
          return PieChartSectionData(
            value: value,
            title: key.name,
            color: key.color,
          );
        },
      ).toList();

      return PieChartData(sections: sectionData);
    });
  }

  Stream<PieChartData> incomesByCategory() {
    return db.incomesTable.all().watch().map((incomes) {
      var incomesTotalByCategory = <IncomeCategory, double>{};

      for (var income in incomes) {
        if (income.category == null) {
          continue;
        }

        if (incomesTotalByCategory[income.category!] == null) {
          incomesTotalByCategory[income.category!] = 0.0;
        }
        incomesTotalByCategory[income.category!] =
            incomesTotalByCategory[income.category!]! + income.incomeValue;
      }

      final sectionData = incomesTotalByCategory.entries.map(
        (entry) {
          final key = entry.key;
          final value = entry.value;
          return PieChartSectionData(
            value: value,
            title: key.name,
            color: key.color,
          );
        },
      ).toList();

      return PieChartData(sections: sectionData);
    });
  }
}
