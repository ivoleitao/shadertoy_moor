import 'package:moor/moor.dart';

@DataClassName('PlaylistShaderEntry')
class PlaylistShaderTable extends Table {
  @override
  String get tableName => 'PlaylistShader';

  TextColumn get playlistId =>
      text().customConstraint('REFERENCES Playlist(id)')();
  TextColumn get shaderId => text().customConstraint('REFERENCES Shader(id)')();

  @override
  Set<Column> get primaryKey => {playlistId, shaderId};
}
