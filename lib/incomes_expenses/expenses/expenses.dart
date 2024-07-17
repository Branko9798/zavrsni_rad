import 'package:drift/drift.dart' hide JsonKey;
import 'package:zavrsni_rad/database/database.dart';
import 'package:zavrsni_rad/incomes_expenses/expenses/expense_category.dart';
import 'package:zavrsni_rad/incomes_expenses/expenses/expense_category_model.dart';
import 'package:zavrsni_rad/main.dart';

class Expense implements Insertable<Expense> {
  final String id;
  final String expenseNote;
  final double expenseValue;
  final String expensesCategoryId;
  final DateTime date;
  final String userId;

    Future<ExpenseCategory?> get category async =>
      getIt<ExpenseCategoryModel>().getCategory(expensesCategoryId);

  Expense(
    this.id,
    this.expenseNote,
    this.expenseValue,
    this.expensesCategoryId,
    this.date,
    this.userId,
  );

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return ExpensesTableCompanion(
      id: Value(id),
      expenseNote: Value(expenseNote),
      expenseValue: Value(expenseValue),
      expensesCategoryId: Value(expensesCategoryId),
      date: Value(date),
      userId: Value(userId),
    ).toColumns(nullToAbsent);
  }
}

@UseRowClass(Expense)
class ExpensesTable extends Table {
  TextColumn get id => text()();
  TextColumn get expenseNote => text()();
  RealColumn get expenseValue => real()();
  TextColumn get expensesCategoryId => text()();
  DateTimeColumn get date => dateTime().withDefault(currentDate)();
  TextColumn get userId => text()();

  @override
  Set<Column> get primaryKey => {id};
}
