import 'package:drift/drift.dart';
import 'package:zavrsni_rad/database/database.dart';
import 'package:zavrsni_rad/main.dart';
import 'package:zavrsni_rad/incomes_expenses/expenses/expenses.dart';

class ExpensesModel {
  final db = getIt<AppDatabase>();

  Stream<List<Expense>> get allExpensesStream => db.expensesTable.all().watch();

  Stream<List<Expense>> filteredExpenses(List<String> categories) {
    return (db.expensesTable.select()
          ..where((tbl) => tbl.expensesCategoryId.isIn(categories)))
        .watch();
  }

    Stream<List<Expense>> searchExpenses(String searchQuery) {
    return (db.expensesTable.select()
          ..where((tbl) => tbl.expenseNote.contains(searchQuery)))
        .watch();
  }

  void addExpense(Expense expense) async {
    await db.expensesTable.insert().insert(expense);
  }

  void removeExpense(Expense expense) async {
    await db.expensesTable.delete().delete(expense);
  }

  void updateExpenses(Expense expense) async {
    await db.expensesTable.update().replace(expense);
  }
}
