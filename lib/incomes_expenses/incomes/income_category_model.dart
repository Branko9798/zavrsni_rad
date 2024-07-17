import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:zavrsni_rad/database/database.dart';

import 'package:zavrsni_rad/incomes_expenses/incomes/income_category.dart';
import 'package:zavrsni_rad/main.dart';

class IncomeCategoryModel {
  final db = getIt<AppDatabase>();

  void addIncomeCategory(IncomeCategory incomeCategory) async {
    await db.incomesCategoryTable.insert().insert(incomeCategory);
  }

  Future<IncomeCategory> getCategory(String categoryId) async {
    return await (db.incomesCategoryTable.select()
          ..where((tbl) => tbl.categoryId.equals(categoryId)))
        .getSingle();
  }

  Stream<List<IncomeCategory>> allCategories() {
    return db.incomesCategoryTable.select().watch();
  }

  Stream<String> getCategoryName(String categoryId) {
    return (db.incomesCategoryTable.select()
          ..where((tbl) => tbl.categoryId.equals(categoryId)))
        .watchSingle()
        .map((category) => category.categoryName);
  }
}
