// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $RevenuesTableTable extends RevenuesTable
    with TableInfo<$RevenuesTableTable, Revenue> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RevenuesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _revenueMeta =
      const VerificationMeta('revenue');
  @override
  late final GeneratedColumn<double> revenue = GeneratedColumn<double>(
      'revenue', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, revenue];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'revenues_table';
  @override
  VerificationContext validateIntegrity(Insertable<Revenue> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('revenue')) {
      context.handle(_revenueMeta,
          revenue.isAcceptableOrUnknown(data['revenue']!, _revenueMeta));
    } else if (isInserting) {
      context.missing(_revenueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Revenue map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Revenue(
      attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}revenue'])!,
    );
  }

  @override
  $RevenuesTableTable createAlias(String alias) {
    return $RevenuesTableTable(attachedDatabase, alias);
  }
}

class RevenuesTableCompanion extends UpdateCompanion<Revenue> {
  final Value<String> id;
  final Value<double> revenue;
  final Value<int> rowid;
  const RevenuesTableCompanion({
    this.id = const Value.absent(),
    this.revenue = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RevenuesTableCompanion.insert({
    required String id,
    required double revenue,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        revenue = Value(revenue);
  static Insertable<Revenue> custom({
    Expression<String>? id,
    Expression<double>? revenue,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (revenue != null) 'revenue': revenue,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RevenuesTableCompanion copyWith(
      {Value<String>? id, Value<double>? revenue, Value<int>? rowid}) {
    return RevenuesTableCompanion(
      id: id ?? this.id,
      revenue: revenue ?? this.revenue,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (revenue.present) {
      map['revenue'] = Variable<double>(revenue.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RevenuesTableCompanion(')
          ..write('id: $id, ')
          ..write('revenue: $revenue, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTableTable extends ExpensesTable
    with TableInfo<$ExpensesTableTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _expenseNameMeta =
      const VerificationMeta('expenseName');
  @override
  late final GeneratedColumn<String> expenseName = GeneratedColumn<String>(
      'expense_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _expenseValueMeta =
      const VerificationMeta('expenseValue');
  @override
  late final GeneratedColumn<double> expenseValue = GeneratedColumn<double>(
      'expense_value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, expenseName, expenseValue];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses_table';
  @override
  VerificationContext validateIntegrity(Insertable<Expense> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('expense_name')) {
      context.handle(
          _expenseNameMeta,
          expenseName.isAcceptableOrUnknown(
              data['expense_name']!, _expenseNameMeta));
    } else if (isInserting) {
      context.missing(_expenseNameMeta);
    }
    if (data.containsKey('expense_value')) {
      context.handle(
          _expenseValueMeta,
          expenseValue.isAcceptableOrUnknown(
              data['expense_value']!, _expenseValueMeta));
    } else if (isInserting) {
      context.missing(_expenseValueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}expense_value'])!,
    );
  }

  @override
  $ExpensesTableTable createAlias(String alias) {
    return $ExpensesTableTable(attachedDatabase, alias);
  }
}

class ExpensesTableCompanion extends UpdateCompanion<Expense> {
  final Value<String> id;
  final Value<String> expenseName;
  final Value<double> expenseValue;
  final Value<int> rowid;
  const ExpensesTableCompanion({
    this.id = const Value.absent(),
    this.expenseName = const Value.absent(),
    this.expenseValue = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesTableCompanion.insert({
    required String id,
    required String expenseName,
    required double expenseValue,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        expenseName = Value(expenseName),
        expenseValue = Value(expenseValue);
  static Insertable<Expense> custom({
    Expression<String>? id,
    Expression<String>? expenseName,
    Expression<double>? expenseValue,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (expenseName != null) 'expense_name': expenseName,
      if (expenseValue != null) 'expense_value': expenseValue,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? expenseName,
      Value<double>? expenseValue,
      Value<int>? rowid}) {
    return ExpensesTableCompanion(
      id: id ?? this.id,
      expenseName: expenseName ?? this.expenseName,
      expenseValue: expenseValue ?? this.expenseValue,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (expenseName.present) {
      map['expense_name'] = Variable<String>(expenseName.value);
    }
    if (expenseValue.present) {
      map['expense_value'] = Variable<double>(expenseValue.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesTableCompanion(')
          ..write('id: $id, ')
          ..write('expenseName: $expenseName, ')
          ..write('expenseValue: $expenseValue, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $RevenuesTableTable revenuesTable = $RevenuesTableTable(this);
  late final $ExpensesTableTable expensesTable = $ExpensesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [revenuesTable, expensesTable];
}
