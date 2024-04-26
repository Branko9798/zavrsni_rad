import 'package:drift/drift.dart' hide JsonKey;
import 'package:zavrsni_rad/database/database.dart';
import 'package:zavrsni_rad/revenues_expenses/expenses/expense_category.dart';

class Expense implements Insertable<Expense> {
  final String id;
  final String expenseNote;
  final double expenseValue;
  final String iconId; // TODO: rename to category ID
  final String iconName; // TODO: remove

  ExpenseCategory? get category => ExpenseCategory.findCategoryId(iconId);

  Expense(
      this.id, this.expenseNote, this.expenseValue, this.iconId, this.iconName);

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return ExpensesTableCompanion(
      id: Value(id),
      expenseNote: Value(expenseNote),
      expenseValue: Value(expenseValue),
      iconId: Value(iconId),
      iconName: Value(iconName),
    ).toColumns(nullToAbsent);
  }
}

@UseRowClass(Expense)
class ExpensesTable extends Table {
  TextColumn get id => text()();
  TextColumn get expenseNote => text()();
  RealColumn get expenseValue => real()();
  TextColumn get iconId => text()();
  TextColumn get iconName => text()();

  @override
  Set<Column> get primaryKey => {id};
}
