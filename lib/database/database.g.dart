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
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDate);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, incomeNote, incomeValue, incomeCategoryId, date, userId];
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
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
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
      attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
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
  final Value<DateTime> date;
  final Value<String> userId;
  final Value<int> rowid;
  const IncomesTableCompanion({
    this.id = const Value.absent(),
    this.incomeNote = const Value.absent(),
    this.incomeValue = const Value.absent(),
    this.incomeCategoryId = const Value.absent(),
    this.date = const Value.absent(),
    this.userId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IncomesTableCompanion.insert({
    required String id,
    required String incomeNote,
    required double incomeValue,
    required String incomeCategoryId,
    this.date = const Value.absent(),
    required String userId,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        incomeNote = Value(incomeNote),
        incomeValue = Value(incomeValue),
        incomeCategoryId = Value(incomeCategoryId),
        userId = Value(userId);
  static Insertable<Income> custom({
    Expression<String>? id,
    Expression<String>? incomeNote,
    Expression<double>? incomeValue,
    Expression<String>? incomeCategoryId,
    Expression<DateTime>? date,
    Expression<String>? userId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (incomeNote != null) 'income_note': incomeNote,
      if (incomeValue != null) 'income_value': incomeValue,
      if (incomeCategoryId != null) 'income_category_id': incomeCategoryId,
      if (date != null) 'date': date,
      if (userId != null) 'user_id': userId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IncomesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? incomeNote,
      Value<double>? incomeValue,
      Value<String>? incomeCategoryId,
      Value<DateTime>? date,
      Value<String>? userId,
      Value<int>? rowid}) {
    return IncomesTableCompanion(
      id: id ?? this.id,
      incomeNote: incomeNote ?? this.incomeNote,
      incomeValue: incomeValue ?? this.incomeValue,
      incomeCategoryId: incomeCategoryId ?? this.incomeCategoryId,
      date: date ?? this.date,
      userId: userId ?? this.userId,
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
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
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
          ..write('date: $date, ')
          ..write('userId: $userId, ')
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
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDate);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, expenseNote, expenseValue, expensesCategoryId, date, userId];
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
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
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
      attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
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
  final Value<DateTime> date;
  final Value<String> userId;
  final Value<int> rowid;
  const ExpensesTableCompanion({
    this.id = const Value.absent(),
    this.expenseNote = const Value.absent(),
    this.expenseValue = const Value.absent(),
    this.expensesCategoryId = const Value.absent(),
    this.date = const Value.absent(),
    this.userId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesTableCompanion.insert({
    required String id,
    required String expenseNote,
    required double expenseValue,
    required String expensesCategoryId,
    this.date = const Value.absent(),
    required String userId,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        expenseNote = Value(expenseNote),
        expenseValue = Value(expenseValue),
        expensesCategoryId = Value(expensesCategoryId),
        userId = Value(userId);
  static Insertable<Expense> custom({
    Expression<String>? id,
    Expression<String>? expenseNote,
    Expression<double>? expenseValue,
    Expression<String>? expensesCategoryId,
    Expression<DateTime>? date,
    Expression<String>? userId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (expenseNote != null) 'expense_note': expenseNote,
      if (expenseValue != null) 'expense_value': expenseValue,
      if (expensesCategoryId != null)
        'expenses_category_id': expensesCategoryId,
      if (date != null) 'date': date,
      if (userId != null) 'user_id': userId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? expenseNote,
      Value<double>? expenseValue,
      Value<String>? expensesCategoryId,
      Value<DateTime>? date,
      Value<String>? userId,
      Value<int>? rowid}) {
    return ExpensesTableCompanion(
      id: id ?? this.id,
      expenseNote: expenseNote ?? this.expenseNote,
      expenseValue: expenseValue ?? this.expenseValue,
      expensesCategoryId: expensesCategoryId ?? this.expensesCategoryId,
      date: date ?? this.date,
      userId: userId ?? this.userId,
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
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
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
          ..write('date: $date, ')
          ..write('userId: $userId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserTableTable extends UserTable with TableInfo<$UserTableTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [userId, firstName, lastName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_table';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name'])!,
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name'])!,
    );
  }

  @override
  $UserTableTable createAlias(String alias) {
    return $UserTableTable(attachedDatabase, alias);
  }
}

class UserTableCompanion extends UpdateCompanion<User> {
  final Value<String> userId;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<int> rowid;
  const UserTableCompanion({
    this.userId = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserTableCompanion.insert({
    required String userId,
    required String firstName,
    required String lastName,
    this.rowid = const Value.absent(),
  })  : userId = Value(userId),
        firstName = Value(firstName),
        lastName = Value(lastName);
  static Insertable<User> custom({
    Expression<String>? userId,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserTableCompanion copyWith(
      {Value<String>? userId,
      Value<String>? firstName,
      Value<String>? lastName,
      Value<int>? rowid}) {
    return UserTableCompanion(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserTableCompanion(')
          ..write('userId: $userId, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $IncomesCategoryTableTable extends IncomesCategoryTable
    with TableInfo<$IncomesCategoryTableTable, IncomeCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IncomesCategoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryNameMeta =
      const VerificationMeta('categoryName');
  @override
  late final GeneratedColumn<String> categoryName = GeneratedColumn<String>(
      'category_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryColorMeta =
      const VerificationMeta('categoryColor');
  @override
  late final GeneratedColumn<int> categoryColor = GeneratedColumn<int>(
      'category_color', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [categoryId, categoryName, categoryColor, userId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'incomes_category_table';
  @override
  VerificationContext validateIntegrity(Insertable<IncomeCategory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('category_name')) {
      context.handle(
          _categoryNameMeta,
          categoryName.isAcceptableOrUnknown(
              data['category_name']!, _categoryNameMeta));
    } else if (isInserting) {
      context.missing(_categoryNameMeta);
    }
    if (data.containsKey('category_color')) {
      context.handle(
          _categoryColorMeta,
          categoryColor.isAcceptableOrUnknown(
              data['category_color']!, _categoryColorMeta));
    } else if (isInserting) {
      context.missing(_categoryColorMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {categoryId};
  @override
  IncomeCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IncomeCategory(
      attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id'])!,
      attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_name'])!,
      attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_color'])!,
      attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
    );
  }

  @override
  $IncomesCategoryTableTable createAlias(String alias) {
    return $IncomesCategoryTableTable(attachedDatabase, alias);
  }
}

class IncomesCategoryTableCompanion extends UpdateCompanion<IncomeCategory> {
  final Value<String> categoryId;
  final Value<String> categoryName;
  final Value<int> categoryColor;
  final Value<String> userId;
  final Value<int> rowid;
  const IncomesCategoryTableCompanion({
    this.categoryId = const Value.absent(),
    this.categoryName = const Value.absent(),
    this.categoryColor = const Value.absent(),
    this.userId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IncomesCategoryTableCompanion.insert({
    required String categoryId,
    required String categoryName,
    required int categoryColor,
    required String userId,
    this.rowid = const Value.absent(),
  })  : categoryId = Value(categoryId),
        categoryName = Value(categoryName),
        categoryColor = Value(categoryColor),
        userId = Value(userId);
  static Insertable<IncomeCategory> custom({
    Expression<String>? categoryId,
    Expression<String>? categoryName,
    Expression<int>? categoryColor,
    Expression<String>? userId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (categoryId != null) 'category_id': categoryId,
      if (categoryName != null) 'category_name': categoryName,
      if (categoryColor != null) 'category_color': categoryColor,
      if (userId != null) 'user_id': userId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IncomesCategoryTableCompanion copyWith(
      {Value<String>? categoryId,
      Value<String>? categoryName,
      Value<int>? categoryColor,
      Value<String>? userId,
      Value<int>? rowid}) {
    return IncomesCategoryTableCompanion(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      categoryColor: categoryColor ?? this.categoryColor,
      userId: userId ?? this.userId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (categoryName.present) {
      map['category_name'] = Variable<String>(categoryName.value);
    }
    if (categoryColor.present) {
      map['category_color'] = Variable<int>(categoryColor.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IncomesCategoryTableCompanion(')
          ..write('categoryId: $categoryId, ')
          ..write('categoryName: $categoryName, ')
          ..write('categoryColor: $categoryColor, ')
          ..write('userId: $userId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpenseCategoryTableTable extends ExpenseCategoryTable
    with TableInfo<$ExpenseCategoryTableTable, ExpenseCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpenseCategoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryNameMeta =
      const VerificationMeta('categoryName');
  @override
  late final GeneratedColumn<String> categoryName = GeneratedColumn<String>(
      'category_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryColorMeta =
      const VerificationMeta('categoryColor');
  @override
  late final GeneratedColumn<int> categoryColor = GeneratedColumn<int>(
      'category_color', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [categoryId, categoryName, categoryColor, userId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expense_category_table';
  @override
  VerificationContext validateIntegrity(Insertable<ExpenseCategory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('category_name')) {
      context.handle(
          _categoryNameMeta,
          categoryName.isAcceptableOrUnknown(
              data['category_name']!, _categoryNameMeta));
    } else if (isInserting) {
      context.missing(_categoryNameMeta);
    }
    if (data.containsKey('category_color')) {
      context.handle(
          _categoryColorMeta,
          categoryColor.isAcceptableOrUnknown(
              data['category_color']!, _categoryColorMeta));
    } else if (isInserting) {
      context.missing(_categoryColorMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {categoryId};
  @override
  ExpenseCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseCategory(
      attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id'])!,
      attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_name'])!,
      attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_color'])!,
      attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
    );
  }

  @override
  $ExpenseCategoryTableTable createAlias(String alias) {
    return $ExpenseCategoryTableTable(attachedDatabase, alias);
  }
}

class ExpenseCategoryTableCompanion extends UpdateCompanion<ExpenseCategory> {
  final Value<String> categoryId;
  final Value<String> categoryName;
  final Value<int> categoryColor;
  final Value<String> userId;
  final Value<int> rowid;
  const ExpenseCategoryTableCompanion({
    this.categoryId = const Value.absent(),
    this.categoryName = const Value.absent(),
    this.categoryColor = const Value.absent(),
    this.userId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpenseCategoryTableCompanion.insert({
    required String categoryId,
    required String categoryName,
    required int categoryColor,
    required String userId,
    this.rowid = const Value.absent(),
  })  : categoryId = Value(categoryId),
        categoryName = Value(categoryName),
        categoryColor = Value(categoryColor),
        userId = Value(userId);
  static Insertable<ExpenseCategory> custom({
    Expression<String>? categoryId,
    Expression<String>? categoryName,
    Expression<int>? categoryColor,
    Expression<String>? userId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (categoryId != null) 'category_id': categoryId,
      if (categoryName != null) 'category_name': categoryName,
      if (categoryColor != null) 'category_color': categoryColor,
      if (userId != null) 'user_id': userId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpenseCategoryTableCompanion copyWith(
      {Value<String>? categoryId,
      Value<String>? categoryName,
      Value<int>? categoryColor,
      Value<String>? userId,
      Value<int>? rowid}) {
    return ExpenseCategoryTableCompanion(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      categoryColor: categoryColor ?? this.categoryColor,
      userId: userId ?? this.userId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (categoryName.present) {
      map['category_name'] = Variable<String>(categoryName.value);
    }
    if (categoryColor.present) {
      map['category_color'] = Variable<int>(categoryColor.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseCategoryTableCompanion(')
          ..write('categoryId: $categoryId, ')
          ..write('categoryName: $categoryName, ')
          ..write('categoryColor: $categoryColor, ')
          ..write('userId: $userId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $IncomesTableTable incomesTable = $IncomesTableTable(this);
  late final $ExpensesTableTable expensesTable = $ExpensesTableTable(this);
  late final $UserTableTable userTable = $UserTableTable(this);
  late final $IncomesCategoryTableTable incomesCategoryTable =
      $IncomesCategoryTableTable(this);
  late final $ExpenseCategoryTableTable expenseCategoryTable =
      $ExpenseCategoryTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        incomesTable,
        expensesTable,
        userTable,
        incomesCategoryTable,
        expenseCategoryTable
      ];
}
