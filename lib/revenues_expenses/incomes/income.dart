import 'package:drift/drift.dart' hide JsonKey;
import 'package:zavrsni_rad/database/database.dart';
import 'package:zavrsni_rad/revenues_expenses/incomes/income_category.dart';

class Income implements Insertable<Income> {
  final String id;
  final String incomeNote;
  final double incomeValue;
  final String incomeCategoryId;

  IncomeCategory? get category => IncomeCategory.findCategoryId(incomeCategoryId);

  Income(this.id, this.incomeNote, this.incomeValue, this.incomeCategoryId);

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return IncomesTableCompanion(
      id: Value(id),
      incomeNote: Value(incomeNote),
      incomeValue: Value(incomeValue),
      incomeCategoryId: Value(incomeCategoryId),
    ).toColumns(nullToAbsent);
  }
}

@UseRowClass(Income)
class IncomesTable extends Table {
  TextColumn get id => text()();
  TextColumn get incomeNote => text()();
  RealColumn get incomeValue => real()();
  TextColumn get incomeCategoryId => text()();


  @override
  Set<Column> get primaryKey => {id};
}
