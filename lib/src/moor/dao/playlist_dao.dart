import 'package:moor/moor.dart';
import 'package:shadertoy_api/shadertoy_api.dart';
import 'package:shadertoy_moor/src/moor/store.dart';
import 'package:shadertoy_moor/src/moor/table/playlist_shader_table.dart';
import 'package:shadertoy_moor/src/moor/table/playlist_table.dart';

part 'playlist_dao.g.dart';

@UseDao(tables: [PlaylistTable, PlaylistShaderTable])
class PlaylistDao extends DatabaseAccessor<MoorStore> with _$PlaylistDaoMixin {
  PlaylistDao(MoorStore store) : super(store);

  String _toShaderIdValue(PlaylistShaderEntry entry) {
    return entry.shaderId;
  }

  Playlist _toPlaylistEntity(PlaylistEntry entry, List<String> shaderIds) {
    return entry != null
        ? Playlist(
            id: entry.id,
            name: entry.name,
            count: shaderIds.length,
            shaders: shaderIds)
        : null;
  }

  Playlist _mapPlaylistEntity(List<TypedResult> results) {
    TypedResult tr;
    var shaderIds = <String>[];
    Playlist playlist;
    for (var i = 0; i < results.length; i++) {
      tr = results[i];

      shaderIds.add(_toShaderIdValue(tr.readTable(playlistShaderTable)));

      if (i == results.length - 1) {
        playlist = _toPlaylistEntity(tr.readTable(playlistTable), shaderIds);
      }
    }

    return playlist;
  }

  Future<Playlist> findById(String playlistId) async {
    return (select(playlistTable)
          ..where((entry) => entry.id.equals(playlistId)))
        .join([
          innerJoin(playlistShaderTable,
              playlistShaderTable.playlistId.equalsExp(playlistTable.id))
        ])
        .get()
        .then(_mapPlaylistEntity);
  }

  PlaylistEntry _toPlaylistEntry(Playlist playlist) {
    return PlaylistEntry(id: playlist.id, name: playlist.name);
  }

  List<PlaylistShaderEntry> _toPlaylistShaderEntries(Playlist playlist) {
    return playlist.shaders.map((shaderId) =>
        PlaylistShaderEntry(playlistId: playlist.id, shaderId: shaderId));
  }

  Future<void> save(Playlist playlist) {
    return transaction(() async {
      await into(playlistTable)
          .insert(_toPlaylistEntry(playlist), orReplace: true);

      await (delete(playlistShaderTable)
            ..where((entry) => entry.playlistId.equals(playlist.id)))
          .go();

      await batch((b) =>
          b.insertAll(playlistShaderTable, _toPlaylistShaderEntries(playlist)));
    });
  }
}
