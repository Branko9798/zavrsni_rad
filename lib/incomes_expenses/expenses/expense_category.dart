import 'package:drift/drift.dart' hide JsonKey;
import 'package:zavrsni_rad/database/database.dart';

class ExpenseCategory implements Insertable<ExpenseCategory> {
  final String categoryId;
  final String categoryName;
  final int categoryColor;
  final String userId;

  const ExpenseCategory(
      this.categoryId, this.categoryName, this.categoryColor, this.userId);

     

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return ExpenseCategoryTableCompanion(
            categoryId: Value(categoryId),
            categoryName: Value(categoryName),
            categoryColor: Value(categoryColor),
            userId: Value(userId))
        .toColumns(nullToAbsent);
  }
}

@UseRowClass(ExpenseCategory)
class ExpenseCategoryTable extends Table {
  TextColumn get categoryId => text()();
  TextColumn get categoryName => text()();
  IntColumn get categoryColor => integer()();

  TextColumn get userId => text()();

  @override
  Set<Column> get primaryKey => {categoryId};
}
