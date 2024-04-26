// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $IncomesTableTable extends IncomesTable
    with TableInfo<$IncomesTableTable, Income> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IncomesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _incomeNoteMeta =
      const VerificationMeta('incomeNote');
  @override
  late final GeneratedColumn<String> incomeNote = GeneratedColumn<String>(
      'income_note', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _incomeValueMeta =
      const VerificationMeta('incomeValue');
  @override
  late final GeneratedColumn<double> incomeValue = GeneratedColumn<double>(
      'income_value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _incomeCategoryIdMeta =
      const VerificationMeta('incomeCategoryId');
  @override
  late final GeneratedColumn<String> incomeCategoryId = GeneratedColumn<String>(
      'income_category_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, incomeNote, incomeValue, incomeCategoryId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'incomes_table';
  @override
  VerificationContext validateIntegrity(Insertable<Income> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('income_note')) {
      context.handle(
          _incomeNoteMeta,
          incomeNote.isAcceptableOrUnknown(
              data['income_note']!, _incomeNoteMeta));
    } else if (isInserting) {
      context.missing(_incomeNoteMeta);
    }
    if (data.containsKey('income_value')) {
      context.handle(
          _incomeValueMeta,
          incomeValue.isAcceptableOrUnknown(
              data['income_value']!, _incomeValueMeta));
    } else if (isInserting) {
      context.missing(_incomeValueMeta);
    }
    if (data.containsKey('income_category_id')) {
      context.handle(
          _incomeCategoryIdMeta,
          incomeCategoryId.isAcceptableOrUnknown(
              data['income_category_id']!, _incomeCategoryIdMeta));
    } else if (isInserting) {
      context.missing(_incomeCategoryIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Income map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Income(
      attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}income_note'])!,
      attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}income_value'])!,
      attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}income_category_id'])!,
    );
  }

  @override
  $IncomesTableTable createAlias(String alias) {
    return $IncomesTableTable(attachedDatabase, alias);
  }
}

class IncomesTableCompanion extends UpdateCompanion<Income> {
  final Value<String> id;
  final Value<String> incomeNote;
  final Value<double> incomeValue;
  final Value<String> incomeCategoryId;
  final Value<int> rowid;
  const IncomesTableCompanion({
    this.id = const Value.absent(),
    this.incomeNote = const Value.absent(),
    this.incomeValue = const Value.absent(),
    this.incomeCategoryId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IncomesTableCompanion.insert({
    required String id,
    required String incomeNote,
    required double incomeValue,
    required String incomeCategoryId,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        incomeNote = Value(incomeNote),
        incomeValue = Value(incomeValue),
        incomeCategoryId = Value(incomeCategoryId);
  static Insertable<Income> custom({
    Expression<String>? id,
    Expression<String>? incomeNote,
    Expression<double>? incomeValue,
    Expression<String>? incomeCategoryId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (incomeNote != null) 'income_note': incomeNote,
      if (incomeValue != null) 'income_value': incomeValue,
      if (incomeCategoryId != null) 'income_category_id': incomeCategoryId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IncomesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? incomeNote,
      Value<double>? incomeValue,
      Value<String>? incomeCategoryId,
      Value<int>? rowid}) {
    return IncomesTableCompanion(
      id: id ?? this.id,
      incomeNote: incomeNote ?? this.incomeNote,
      incomeValue: incomeValue ?? this.incomeValue,
      incomeCategoryId: incomeCategoryId ?? this.incomeCategoryId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (incomeNote.present) {
      map['income_note'] = Variable<String>(incomeNote.value);
    }
    if (incomeValue.present) {
      map['income_value'] = Variable<double>(incomeValue.value);
    }
    if (incomeCategoryId.present) {
      map['income_category_id'] = Variable<String>(incomeCategoryId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IncomesTableCompanion(')
          ..write('id: $id, ')
          ..write('incomeNote: $incomeNote, ')
          ..write('incomeValue: $incomeValue, ')
          ..write('incomeCategoryId: $incomeCategoryId, ')
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
  static const VerificationMeta _expenseNoteMeta =
      const VerificationMeta('expenseNote');
  @override
  late final GeneratedColumn<String> expenseNote = GeneratedColumn<String>(
      'expense_note', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _expenseValueMeta =
      const VerificationMeta('expenseValue');
  @override
  late final GeneratedColumn<double> expenseValue = GeneratedColumn<double>(
      'expense_value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _expensesCategoryIdMeta =
      const VerificationMeta('expensesCategoryId');
  @override
  late final GeneratedColumn<String> expensesCategoryId =
      GeneratedColumn<String>('expenses_category_id', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, expenseNote, expenseValue, expensesCategoryId];
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
    if (data.containsKey('expense_note')) {
      context.handle(
          _expenseNoteMeta,
          expenseNote.isAcceptableOrUnknown(
              data['expense_note']!, _expenseNoteMeta));
    } else if (isInserting) {
      context.missing(_expenseNoteMeta);
    }
    if (data.containsKey('expense_value')) {
      context.handle(
          _expenseValueMeta,
          expenseValue.isAcceptableOrUnknown(
              data['expense_value']!, _expenseValueMeta));
    } else if (isInserting) {
      context.missing(_expenseValueMeta);
    }
    if (data.containsKey('expenses_category_id')) {
      context.handle(
          _expensesCategoryIdMeta,
          expensesCategoryId.isAcceptableOrUnknown(
              data['expenses_category_id']!, _expensesCategoryIdMeta));
    } else if (isInserting) {
      context.missing(_expensesCategoryIdMeta);
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
          .read(DriftSqlType.string, data['${effectivePrefix}expense_note'])!,
      attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}expense_value'])!,
      attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}expenses_category_id'])!,
    );
  }

  @override
  $ExpensesTableTable createAlias(String alias) {
    return $ExpensesTableTable(attachedDatabase, alias);
  }
}

class ExpensesTableCompanion extends UpdateCompanion<Expense> {
  final Value<String> id;
  final Value<String> expenseNote;
  final Value<double> expenseValue;
  final Value<String> expensesCategoryId;
  final Value<int> rowid;
  const ExpensesTableCompanion({
    this.id = const Value.absent(),
    this.expenseNote = const Value.absent(),
    this.expenseValue = const Value.absent(),
    this.expensesCategoryId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesTableCompanion.insert({
    required String id,
    required String expenseNote,
    required double expenseValue,
    required String expensesCategoryId,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        expenseNote = Value(expenseNote),
        expenseValue = Value(expenseValue),
        expensesCategoryId = Value(expensesCategoryId);
  static Insertable<Expense> custom({
    Expression<String>? id,
    Expression<String>? expenseNote,
    Expression<double>? expenseValue,
    Expression<String>? expensesCategoryId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (expenseNote != null) 'expense_note': expenseNote,
      if (expenseValue != null) 'expense_value': expenseValue,
      if (expensesCategoryId != null)
        'expenses_category_id': expensesCategoryId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? expenseNote,
      Value<double>? expenseValue,
      Value<String>? expensesCategoryId,
      Value<int>? rowid}) {
    return ExpensesTableCompanion(
      id: id ?? this.id,
      expenseNote: expenseNote ?? this.expenseNote,
      expenseValue: expenseValue ?? this.expenseValue,
      expensesCategoryId: expensesCategoryId ?? this.expensesCategoryId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (expenseNote.present) {
      map['expense_note'] = Variable<String>(expenseNote.value);
    }
    if (expenseValue.present) {
      map['expense_value'] = Variable<double>(expenseValue.value);
    }
    if (expensesCategoryId.present) {
      map['expenses_category_id'] = Variable<String>(expensesCategoryId.value);
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
          ..write('expenseNote: $expenseNote, ')
          ..write('expenseValue: $expenseValue, ')
          ..write('expensesCategoryId: $expensesCategoryId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $IncomesTableTable incomesTable = $IncomesTableTable(this);
  late final $ExpensesTableTable expensesTable = $ExpensesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [incomesTable, expensesTable];
}
