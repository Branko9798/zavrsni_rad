import 'package:drift/drift.dart' hide JsonKey;
import 'package:zavrsni_rad/database/database.dart';
import 'package:zavrsni_rad/incomes_expenses/incomes/income_category.dart';
import 'package:zavrsni_rad/incomes_expenses/incomes/income_category_model.dart';
import 'package:zavrsni_rad/main.dart';

class Income implements Insertable<Income> {
  final String id;
  final String incomeNote;
  final double incomeValue;
  final String incomeCategoryId;
  final DateTime date;
  final String userId;

  Future<IncomeCategory?> get category async =>
      getIt<IncomeCategoryModel>().getCategory(incomeCategoryId);

  Income(this.id, this.incomeNote, this.incomeValue, this.incomeCategoryId,
      this.date, this.userId);

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return IncomesTableCompanion(
            id: Value(id),
            incomeNote: Value(incomeNote),
            incomeValue: Value(incomeValue),
            incomeCategoryId: Value(incomeCategoryId),
            date: Value(date),
            userId: Value(userId))
        .toColumns(nullToAbsent);
  }
}

@UseRowClass(Income)
class IncomesTable extends Table {
  TextColumn get id => text()();
  TextColumn get incomeNote => text()();
  RealColumn get incomeValue => real()();
  TextColumn get incomeCategoryId => text()();
  DateTimeColumn get date => dateTime().withDefault(currentDate)();
  TextColumn get userId => text()();

  @override
  Set<Column> get primaryKey => {id};
}
