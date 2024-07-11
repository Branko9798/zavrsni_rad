import 'package:drift/drift.dart' hide JsonKey;
import 'package:zavrsni_rad/database/database.dart';

class User implements Insertable<User> {
  final String userId;
  final String firstName;
  final String lastName;

  
    User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    
  });

 
  @override
  Map<String, Expression<Object>> toColumns(bool nullToAbsent) {
    return UserTableCompanion(
      userId: Value(userId),
      firstName: Value(firstName),
      lastName: Value(lastName),
    
     
    ).toColumns(nullToAbsent);
  }
}

@UseRowClass(User)
class UserTable extends Table {
  TextColumn get userId => text()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
 


  @override
  Set<Column> get primaryKey => {userId};
}
