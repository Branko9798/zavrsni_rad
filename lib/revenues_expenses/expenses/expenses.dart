import 'package:drift/drift.dart' hide JsonKey;
import 'package:zavrsni_rad/database/database.dart';

class Expense implements Insertable<Expense> {
  final String id;
  final String expenseName;
  final double expenseValue;

  Expense(this.id, this.expenseName, this.expenseValue);

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return ExpensesTableCompanion(
      id: Value(id),
      expenseName: Value(expenseName),
      expenseValue: Value(expenseValue),
    ).toColumns(nullToAbsent);
  }
}

@UseRowClass(Expense)
class ExpensesTable extends Table {
  TextColumn get id => text()();
  TextColumn get expenseName => text()();

  RealColumn get expenseValue => real()();

  @override
  Set<Column> get primaryKey => {id};
}
