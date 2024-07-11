import 'dart:async';

import 'package:drift/drift.dart';
import 'package:zavrsni_rad/database/database.dart';
import 'package:zavrsni_rad/main.dart';
import 'package:zavrsni_rad/user/user.dart';

class UserModel {
  final db = getIt<AppDatabase>();

  void addUser(User user) async {
    await db.userTable.insert().insert(user);
  }

  void updateUser(User user) async {
    await db.userTable.update().replace(user);
  }

  Future<User> getUserFuture() async {
    return await db.userTable.select().getSingle();
  }

  Stream<User> getUserStream() {
    return db.userTable.all().watchSingle();
  }
}
