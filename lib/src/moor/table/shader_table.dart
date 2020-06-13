import 'package:moor/moor.dart';

@DataClassName('ShaderEntry')
class ShaderTable extends Table {
  @override
  String get tableName => 'Shader';

  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get version => text()();
  TextColumn get name => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get description => text().nullable()();
  IntColumn get views => integer().withDefault(Constant(0))();
  IntColumn get likes => integer().withDefault(Constant(0))();
  TextColumn get publishStatus => text().nullable()();
  IntColumn get flags => integer().withDefault(Constant(0))();
  TextColumn get tagsJson => text()();
  BoolColumn get liked => boolean().withDefault(Constant(false))();
  TextColumn get renderPassesJson => text()();

  @override
  Set<Column> get primaryKey => {id};
}
