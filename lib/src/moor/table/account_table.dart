import 'package:moor/moor.dart';

@DataClassName('AccountEntry')
class AccountTable extends Table {
  @override
  String get tableName => 'Account';

  TextColumn get name => text()();
  TextColumn get type => text()();
  BoolColumn get system => boolean()();
  TextColumn get password => text().nullable()();
  TextColumn get displayName => text().nullable()();
  TextColumn get picture => text().nullable()();

  @override
  Set<Column> get primaryKey => {name, type};
}
