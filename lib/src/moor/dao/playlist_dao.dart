import 'package:enum_to_string/enum_to_string.dart';
import 'package:moor/moor.dart';
import 'package:shadertoy_api/shadertoy_api.dart';
import 'package:shadertoy_moor/src/moor/store.dart';
import 'package:shadertoy_moor/src/moor/table/playlist_shader_table.dart';
import 'package:shadertoy_moor/src/moor/table/playlist_table.dart';

part 'playlist_dao.g.dart';

@UseDao(
    tables: [PlaylistTable, PlaylistShaderTable],
    queries: {'playlistId': 'SELECT id FROM Playlist'})

/// Playlist data access object
class PlaylistDao extends DatabaseAccessor<MoorStore> with _$PlaylistDaoMixin {
  /// Creates a [PlaylistDao]
  ///
  /// * [store]: A pre-initialized [MoorStore] store
  PlaylistDao(MoorStore store) : super(store);

  /// Converts a [PlaylistEntry] into a [Playlist]
  ///
  /// * [entry]: The entry to convert
  Playlist _toPlaylistEntity(PlaylistEntry entry) {
    return entry != null
        ? Playlist(
            id: entry.id,
            userId: entry.userId,
            name: entry.name,
            description: entry.description,
            privacy:
                EnumToString.fromString(PlaylistPrivacy.values, entry.privacy))
        : null;
  }

  /// Returns a [Playlist] with id [playlistId]
  ///
  /// * [playlistId]: The id of the playlist
  Future<Playlist> findById(String playlistId) {
    return (select(playlistTable)..where((t) => t.id.equals(playlistId)))
        .getSingle()
        .then(_toPlaylistEntity);
  }

  /// Returns all the playlist ids
  Future<List<String>> findAllIds() {
    return playlistId().get();
  }

  /// Converts a list of [PlaylistEntry] into a list of [Playlist]
  ///
  /// * [entries]: The list of entries to convert
  List<Playlist> _toPlaylistEntities(List<PlaylistEntry> entries) {
    return entries.map((entry) => _toPlaylistEntity(entry)).toList();
  }

  /// Returns all the playlists
  Future<List<Playlist>> findAll() {
    return select(playlistTable).get().then(_toPlaylistEntities);
  }

  /// Converts a [Playlist] into a [PlaylistEntry]
  ///
  /// * [entity]: The entity to convert
  PlaylistEntry _toPlaylistEntry(Playlist entity) {
    return PlaylistEntry(
        id: entity.id,
        userId: entity.userId,
        name: entity.name,
        description: entity.description,
        privacy: EnumToString.convertToString(entity.privacy));
  }

  /// Creates a [PlaylistShaderEntry]
  ///
  /// * [playlistId]: The id of the playlist
  /// * [shaderId]: The id of the shader
  /// * [order]: The order on the playlist
  PlaylistShaderEntry _toPlaylistShaderEntry(
      String playlistId, String shaderId, int order) {
    return PlaylistShaderEntry(
        playlistId: playlistId, shaderId: shaderId, order: order);
  }

  /// Creates a list of [PlaylistShaderEntry]
  ///
  /// * [playlistId]: The id of the playlist
  /// * [shaderIds]: The list of shader ids
  List<PlaylistShaderEntry> _toPlaylistShaderEntries(
      String playlistId, List<String> shaderIds) {
    final entries = <PlaylistShaderEntry>[];
    for (var i = 0; i < shaderIds.length; i++) {
      entries.add(_toPlaylistShaderEntry(playlistId, shaderIds[i], i + 1));
    }

    return entries;
  }

  Future<void> _savePlaylist(Playlist playlist) {
    return into(playlistTable)
        .insert(_toPlaylistEntry(playlist), mode: InsertMode.insertOrReplace);
  }

  Future<void> _savePlaylistShaders(String playlistId, List<String> shaderIds) {
    return batch((b) => b.insertAll(
        playlistShaderTable, _toPlaylistShaderEntries(playlistId, shaderIds),
        mode: InsertMode.insertOrReplace));
  }

  /// Saves a [Playlist]
  ///
  /// * [playlist]: The [Playlist] to save
  ///
  /// Returns the rowid of the inserted row
  Future<void> save(Playlist playlist, {List<String> shaderIds}) {
    if (shaderIds == null) {
      return _savePlaylist(playlist);
    } else {
      return transaction(() async {
        // Save the playlist
        await _savePlaylist(playlist);

        // Then save the playlist shaders
        await _savePlaylistShaders(playlist.id, shaderIds);
      });
    }
  }

  /// Saves playlist shader ids
  ///
  /// * [playlistId]: The id of the playlist
  /// * [shaderIds]: The list of shader ids
  Future<void> savePlaylistShaders(String playlistId, List<String> shaderIds) {
    return _savePlaylistShaders(playlistId, shaderIds);
  }

  /// Deletes a [Playlist] by [Id]
  ///
  /// * [playlistId]: The id of the [Playlist]
  Future<void> deleteById(String playlistId) {
    return (delete(playlistTable)
          ..where((playlist) => playlist.id.equals(playlistId)))
        .go();
  }
}
