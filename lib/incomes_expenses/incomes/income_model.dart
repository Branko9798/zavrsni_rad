import 'package:drift/drift.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zavrsni_rad/database/database.dart';
import 'package:zavrsni_rad/main.dart';
import 'package:zavrsni_rad/incomes_expenses/incomes/income.dart';

class IncomeModel {
  final db = getIt<AppDatabase>();

  Stream<List<Income>> get allIncomesStream => db.incomesTable.all().watch();

  Stream<List<Income>> filteredIncomes(List<String> categories) {
    return (db.incomesTable.select()
          ..where((tbl) => tbl.incomeCategoryId.isIn(categories)))
        .watch();
  }

  Stream<List<Income>> searchIncomes(String searchQuery) {
    return (db.incomesTable.select()
          ..where((tbl) => tbl.incomeNote.contains(searchQuery)))
        .watch();
  }

  void addIncome(Income income) async {
    await db.incomesTable.insert().insert(income);
  }

  void removeIncome(Income income) async {
    await db.incomesTable.delete().delete(income);
  }

  void updateIncome(Income income) async {
    await db.incomesTable.update().replace(income);
  }

 
}
