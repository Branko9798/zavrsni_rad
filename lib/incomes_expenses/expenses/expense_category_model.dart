import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:zavrsni_rad/database/database.dart';
import 'package:zavrsni_rad/incomes_expenses/expenses/expense_category.dart';
import 'package:zavrsni_rad/incomes_expenses/incomes/income_category.dart';
import 'package:zavrsni_rad/main.dart';

class ExpenseCategoryModel {
  final db = getIt<AppDatabase>();

  void addExpenseCategory(ExpenseCategory expenseCategory) async {
    await db.expenseCategoryTable.insert().insert(expenseCategory);
  }

  Future<ExpenseCategory> getCategory(String categoryId) async {
    return await (db.expenseCategoryTable.select()
          ..where((tbl) => tbl.categoryId.equals(categoryId)))
        .getSingle();
  }

  Stream<List<ExpenseCategory>> allCategories() {
    return db.expenseCategoryTable.select().watch();
  }

  Stream<String> getCategoryName(String categoryId) {
    return (db.expenseCategoryTable.select()
          ..where((tbl) => tbl.categoryId.equals(categoryId)))
        .watchSingle()
        .map((category) => category.categoryName);
  }
}
