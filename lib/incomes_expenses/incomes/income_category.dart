import 'package:drift/drift.dart' hide JsonKey;
import 'package:zavrsni_rad/database/database.dart';
import 'package:zavrsni_rad/incomes_expenses/incomes/income.dart';

class IncomeCategory implements Insertable<IncomeCategory> {
  final String categoryId;
  final String categoryName;
  final int categoryColor;
  final String userId;

  const IncomeCategory(
      this.categoryId, this.categoryName, this.categoryColor, this.userId);

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return IncomesCategoryTableCompanion(
            categoryId: Value(categoryId),
            categoryName: Value(categoryName),
            categoryColor: Value(categoryColor),
            userId: Value(userId))
        .toColumns(nullToAbsent);
  }
}

@UseRowClass(IncomeCategory)
class IncomesCategoryTable extends Table {
  TextColumn get categoryId => text()();
  TextColumn get categoryName => text()();
  IntColumn get categoryColor => integer()();

  TextColumn get userId => text()();

  @override
  Set<Column> get primaryKey => {categoryId};
}
