import 'package:drift/drift.dart' hide JsonKey;
import 'package:zavrsni_rad/database/database.dart';
import 'package:zavrsni_rad/revenues_expenses/expenses/expense_category.dart';

class Expense implements Insertable<Expense> {
  final String id;
  final String expenseNote;
  final double expenseValue;
  final String expensesCategoryId; 
        

  ExpenseCategory? get category => ExpenseCategory.findCategoryId(expensesCategoryId);

  Expense(
      this.id, this.expenseNote, this.expenseValue, this.expensesCategoryId, );

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return ExpensesTableCompanion(
      id: Value(id),
      expenseNote: Value(expenseNote),
      expenseValue: Value(expenseValue),
      expensesCategoryId: Value(expensesCategoryId),
    
    ).toColumns(nullToAbsent);
  }
}

@UseRowClass(Expense)
class ExpensesTable extends Table {
  TextColumn get id => text()();
  TextColumn get expenseNote => text()();
  RealColumn get expenseValue => real()();
  TextColumn get expensesCategoryId => text()();


  @override
  Set<Column> get primaryKey => {id};
}
