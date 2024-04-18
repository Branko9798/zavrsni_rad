import 'package:drift/drift.dart' hide JsonKey;
import 'package:zavrsni_rad/database/database.dart';

class Expense implements Insertable<Expense> {
  final String id;
  final double expense;

  Expense(this.id, this.expense);

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return ExpensesTableCompanion(
      id: Value(id),
      expense: Value(expense),
    ).toColumns(nullToAbsent);
  }
}

@UseRowClass(Expense)
class ExpensesTable extends Table {
  TextColumn get id => text()();

  RealColumn get expense => real()();

  @override
  Set<Column> get primaryKey => {id};
}
