import 'package:moor/moor.dart';

@DataClassName('UserEntry')
class UserTable extends Table {
  @override
  String get tableName => 'User';

  TextColumn get id => text()();
  TextColumn get picture => text().nullable()();
  DateTimeColumn get memberSince => dateTime().nullable()();
  IntColumn get shaders => integer().nullable()();
  IntColumn get comments => integer().nullable()();
  TextColumn get about => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
