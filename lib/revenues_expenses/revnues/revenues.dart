import 'package:drift/drift.dart' hide JsonKey;
import 'package:zavrsni_rad/database/database.dart';

class Revenue implements Insertable<Revenue> {
  final String id;
  final double revenue;

  Revenue(this.id, this.revenue);

  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return RevenuesTableCompanion(
      id: Value(id),
      revenue: Value(revenue),
    ).toColumns(nullToAbsent);
  }
}

@UseRowClass(Revenue)
class RevenuesTable extends Table {
  TextColumn get id => text()();

  RealColumn get revenue => real()();

  @override
  Set<Column> get primaryKey => {id};
}
