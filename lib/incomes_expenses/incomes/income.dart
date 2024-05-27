import 'package:drift/drift.dart' hide JsonKey;
import 'package:zavrsni_rad/database/database.dart';
import 'package:zavrsni_rad/incomes_expenses/incomes/income_category.dart';

class Income implements Insertable<Income> {
  final String id;
  final String incomeNote;
  final double incomeValue;
  final String incomeCategoryId;
  final DateTime date;

  IncomeCategory? get category =>
      IncomeCategory.findCategoryId(incomeCategoryId);

  Income(this.id, this.incomeNote, this.incomeValue, this.incomeCategoryId,
      this.date);

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return IncomesTableCompanion(
      id: Value(id),
      incomeNote: Value(incomeNote),
      incomeValue: Value(incomeValue),
      incomeCategoryId: Value(incomeCategoryId),
      date: Value(date),
    ).toColumns(nullToAbsent);
  }
}

@UseRowClass(Income)
class IncomesTable extends Table {
  TextColumn get id => text()();
  TextColumn get incomeNote => text()();
  RealColumn get incomeValue => real()();
  TextColumn get incomeCategoryId => text()();
  DateTimeColumn get date => dateTime().withDefault(currentDate)();

  @override
  Set<Column> get primaryKey => {id};
}
