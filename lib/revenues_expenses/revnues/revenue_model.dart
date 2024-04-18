import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:zavrsni_rad/database/database.dart';
import 'package:zavrsni_rad/main.dart';
import 'package:zavrsni_rad/revenues_expenses/revnues/revenues.dart';

class RevenueModel {
  final revenues = ValueNotifier<List<Revenue>>([]);
  final db = getIt<AppDatabase>();

  void addRevenue(Revenue revenue) async {
    var newValue = revenues.value..add(revenue);
    await db.revenuesTable.insert().insert(revenue);
    revenues.value = newValue;
  }
}
