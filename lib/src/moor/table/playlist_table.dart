import 'package:moor/moor.dart';

@DataClassName('PlaylistEntry')
class PlaylistTable extends Table {
  @override
  String get tableName => 'Playlist';

  TextColumn get id => text()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}
