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
  static const VerificationMeta _iconIdMeta = const VerificationMeta('iconId');
  @override
  late final GeneratedColumn<String> iconId = GeneratedColumn<String>(
      'icon_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconNameMeta =
      const VerificationMeta('iconName');
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
      'icon_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, expenseNote, expenseValue, iconId, iconName];
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
    if (data.containsKey('icon_id')) {
      context.handle(_iconIdMeta,
          iconId.isAcceptableOrUnknown(data['icon_id']!, _iconIdMeta));
    } else if (isInserting) {
      context.missing(_iconIdMeta);
    }
    if (data.containsKey('icon_name')) {
      context.handle(_iconNameMeta,
          iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta));
    } else if (isInserting) {
      context.missing(_iconNameMeta);
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
      attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_id'])!,
      attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_name'])!,
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
  final Value<String> iconId;
  final Value<String> iconName;
  final Value<int> rowid;
  const ExpensesTableCompanion({
    this.id = const Value.absent(),
    this.expenseNote = const Value.absent(),
    this.expenseValue = const Value.absent(),
    this.iconId = const Value.absent(),
    this.iconName = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesTableCompanion.insert({
    required String id,
    required String expenseNote,
    required double expenseValue,
    required String iconId,
    required String iconName,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        expenseNote = Value(expenseNote),
        expenseValue = Value(expenseValue),
        iconId = Value(iconId),
        iconName = Value(iconName);
  static Insertable<Expense> custom({
    Expression<String>? id,
    Expression<String>? expenseNote,
    Expression<double>? expenseValue,
    Expression<String>? iconId,
    Expression<String>? iconName,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (expenseNote != null) 'expense_note': expenseNote,
      if (expenseValue != null) 'expense_value': expenseValue,
      if (iconId != null) 'icon_id': iconId,
      if (iconName != null) 'icon_name': iconName,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? expenseNote,
      Value<double>? expenseValue,
      Value<String>? iconId,
      Value<String>? iconName,
      Value<int>? rowid}) {
    return ExpensesTableCompanion(
      id: id ?? this.id,
      expenseNote: expenseNote ?? this.expenseNote,
      expenseValue: expenseValue ?? this.expenseValue,
      iconId: iconId ?? this.iconId,
      iconName: iconName ?? this.iconName,
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
    if (iconId.present) {
      map['icon_id'] = Variable<String>(iconId.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
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
          ..write('iconId: $iconId, ')
          ..write('iconName: $iconName, ')
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
