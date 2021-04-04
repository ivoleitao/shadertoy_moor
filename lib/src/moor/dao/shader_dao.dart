import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:moor/moor.dart';
import 'package:shadertoy_api/shadertoy_api.dart';
import 'package:shadertoy_moor/src/moor/store.dart';
import 'package:shadertoy_moor/src/moor/table/playlist_shader_table.dart';
import 'package:shadertoy_moor/src/moor/table/playlist_table.dart';
import 'package:shadertoy_moor/src/moor/table/shader_table.dart';

part 'shader_dao.g.dart';

@UseDao(
    tables: [ShaderTable, PlaylistTable, PlaylistShaderTable],
    queries: {'shaderId': 'SELECT id FROM Shader'})

/// Shader data access object
class ShaderDao extends DatabaseAccessor<MoorStore> with _$ShaderDaoMixin {
  /// Creates a [ShaderDao]
  ///
  /// * [store]: A pre-initialized [MoorStore] store
  ShaderDao(MoorStore store) : super(store);

  /// Converts a [ShaderEntry] into a [Info]
  ///
  /// * [entry]: The entry to convert
  Info _toInfoEntity(ShaderEntry entry) {
    return Info(
        id: entry.id,
        date: entry.date,
        views: entry.views,
        name: entry.name,
        userId: entry.userId,
        description: entry.description,
        likes: entry.likes,
        privacy: EnumToString.fromString(ShaderPrivacy.values, entry.privacy),
        flags: entry.flags,
        tags: (jsonDecode(entry.tagsJson) as List<dynamic>)
            .map((e) => e as String)
            .toList());
  }

  /// Converts a [ShaderEntry] into a [Shader]
  ///
  /// * [entry]: The entry to convert
  Shader _toShaderEntity(ShaderEntry entry) {
    return entry != null
        ? Shader(
            version: entry.version,
            info: _toInfoEntity(entry),
            renderPasses: (jsonDecode(entry.renderPassesJson) as List<dynamic>)
                .map((e) => RenderPass.fromJson(e))
                .toList())
        : null;
  }

  /// Checks if a shader exists
  ///
  /// * [shaderId]: The shader id
  ///
  /// Returns `true` if the shader exists
  Future<bool> exists(String shaderId) {
    return (select(shaderTable)..where((entry) => entry.id.equals(shaderId)))
        .getSingle()
        .then((value) => value != null);
  }

  /// Returns a [Shader] with id [shaderId]
  ///
  /// * [shaderId]: The id of the shader
  Future<Shader> findById(String shaderId) {
    return (select(shaderTable)..where((entry) => entry.id.equals(shaderId)))
        .getSingle()
        .then(_toShaderEntity);
  }

  /// Returns all the shader ids
  Future<List<String>> findAllIds() {
    return shaderId().get();
  }

  /// Executes a shader query
  ///
  /// * [term]: Shaders that have [term] in the name or in description
  /// * [userId]: The user id of the author of the shader
  /// * [tags]: A set of tag filters
  /// * [sort]: The sort order of the shaders
  /// * [from]: A 0 based index for results returned
  /// * [num]: The total number of results
  Future<List<ShaderEntry>> _getShaderQuery(
      {String term,
      String userId,
      Set<String> tags,
      Sort sort,
      int from,
      int num}) {
    var hasTerm = term != null && term.isNotEmpty;
    var hasUserId = userId != null && userId.isNotEmpty;
    var hasTags = tags != null && tags.isNotEmpty;

    final query = select(shaderTable);
    if (hasTerm || hasUserId || hasTags) {
      query.where((entry) {
        Expression<bool> exp;

        if (hasTerm) {
          var termExp = entry.name.like(term);
          exp = (exp == null ? termExp : exp & termExp);
        }

        if (hasUserId) {
          var userExp = entry.userId.equals(userId);
          exp = (exp == null ? userExp : exp & userExp);
        }

        if (hasTags) {
          var tagExp;
          for (var tag in tags) {
            tagExp = entry.tagsJson.like('%$tag%');
            exp = (exp == null ? tagExp : exp & tagExp);
          }
        }

        return exp;
      });
    }

    if (sort != null) {
      query.orderBy([
        if (sort == Sort.name)
          (u) => OrderingTerm(
              expression: shaderTable.name, mode: OrderingMode.asc),
        if (sort == Sort.newest)
          (u) => OrderingTerm(
              expression: shaderTable.date, mode: OrderingMode.desc),
        if (sort == Sort.popular)
          (u) => OrderingTerm(
              expression: shaderTable.views, mode: OrderingMode.desc),
        if (sort == Sort.love)
          (u) => OrderingTerm(
              expression: shaderTable.likes, mode: OrderingMode.desc),
        if (sort == Sort.hot)
          (u) => OrderingTerm(
              expression: CustomExpression<RealType>(
                  "(cast(views as real) / (strftime('%s','now') - date))"),
              mode: OrderingMode.desc)
      ]);
    }

    from ??= 0;
    num ??= 0;
    if (from > 0 || num > 0) {
      query.limit(num, offset: from);
    }

    return query.get();
  }

  /// Converts a list of [ShaderEntry] into a list of shader ids
  ///
  /// * [entries]: The list of entries to convert
  List<String> _toShaderIds(List<ShaderEntry> entries) {
    return entries.map((ShaderEntry entry) => entry.id).toList();
  }

  /// Query shader ids
  ///
  /// * [term]: Shaders that have [term] in the name or in description
  /// * [userId]: The user id of the author of the shader
  /// * [filters]: A set of tag filters
  /// * [sort]: The sort order of the shaders
  /// * [from]: A 0 based index for results returned
  /// * [num]: The total number of results
  Future<List<String>> findIds(
      {String term,
      String userId,
      Set<String> filters,
      Sort sort,
      int from,
      int num}) {
    return _getShaderQuery(
            term: term,
            userId: userId,
            tags: filters,
            sort: sort,
            from: from,
            num: num)
        .then(_toShaderIds);
  }

  /// Converts a list of [ShaderEntry] into a list of [Shader]
  ///
  /// * [entries]: The list of entries to convert
  List<Shader> _toShaderEntities(List<ShaderEntry> entries) {
    return entries.map((entry) => _toShaderEntity(entry)).toList();
  }

  /// Query shaders
  ///
  /// * [term]: Shaders that have [term] in the name or in description
  /// * [userId]: The user id of the author of the shader
  /// * [filters]: A set of tag filters
  /// * [sort]: The sort order of the shaders
  /// * [from]: A 0 based index for results returned
  /// * [num]: The total number of results
  Future<List<Shader>> find(
      {String term,
      String userId,
      Set<String> filters,
      Sort sort,
      int from,
      int num}) {
    return _getShaderQuery(
            term: term,
            userId: userId,
            tags: filters,
            sort: sort,
            from: from,
            num: num)
        .then(_toShaderEntities);
  }

  /// Returns a list of playlist shaders
  ///
  /// * [playlistId]: The id of the playlist
  /// * [from]: A 0 based index for results returned
  /// * [num]: The total number of results
  Future<List<ShaderEntry>> _getPlaylistShaderQuery(String playlistId,
      {int from, int num}) {
    final query = select(shaderTable).join([
      innerJoin(playlistShaderTable,
          playlistShaderTable.shaderId.equalsExp(shaderTable.id))
    ])
      ..where(playlistShaderTable.playlistId.equals(playlistId));

    from ??= 0;
    num ??= 0;
    if (from > 0 || num > 0) {
      query.limit(num, offset: from);
    }

    query.orderBy([
      OrderingTerm(
          expression: playlistShaderTable.order, mode: OrderingMode.asc)
    ]);

    return query.get().then(
        (results) => results.map((tr) => tr.readTable(shaderTable)).toList());
  }

  /// Finds playlist shader ids
  ///
  /// * [playlistId]: The id of the playlist
  /// * [from]: A 0 based index for results returned
  /// * [num]: The total number of results
  Future<List<String>> findIdsByPlaylist(String playlistId,
      {int from, int num}) {
    return _getPlaylistShaderQuery(playlistId, from: from, num: num)
        .then(_toShaderIds);
  }

  /// Finds playlist shaders
  ///
  /// * [playlistId]: The id of the playlist
  /// * [from]: A 0 based index for results returned
  /// * [num]: The total number of results
  Future<List<Shader>> findByPlaylist(String playlistId, {int from, int num}) {
    return _getPlaylistShaderQuery(playlistId, from: from, num: num)
        .then(_toShaderEntities);
  }

  /// Converts a [Shader] into a [ShaderEntry]
  ///
  /// * [entity]: The entity to convert
  ShaderEntry _toShaderEntry(Shader entity) {
    return ShaderEntry(
        id: entity.info.id,
        userId: entity.info.userId,
        version: entity.version,
        name: entity.info.name,
        date: entity.info.date,
        description: entity.info.description,
        views: entity.info.views,
        likes: entity.info.likes,
        privacy: EnumToString.convertToString(entity.info.privacy),
        flags: entity.info.flags,
        tagsJson: json.encode(entity.info.tags),
        renderPassesJson: json.encode(
            entity.renderPasses.map((RenderPass rp) => rp.toJson()).toList()));
  }

  /// Saves a [Shader]
  ///
  /// * [shader]: The [Shader] to save
  ///
  /// Returns the rowid of the inserted row
  Future<void> save(Shader shader) {
    return into(shaderTable)
        .insert(_toShaderEntry(shader), mode: InsertMode.insertOrReplace);
  }

  /// Converts a list of [Shader] into a list of [ShaderEntry]
  ///
  /// * [shaders]: The list of [Shader] to convert
  List<ShaderEntry> _toShaderEntries(List<Shader> shaders) {
    return shaders.map((shader) => _toShaderEntry(shader)).toList();
  }

  /// Saves a list of [Shader]
  ///
  /// * [shaders]: The list of [Shader] to save
  Future<void> saveAll(List<Shader> shaders) {
    return batch((b) => b.insertAll(shaderTable, _toShaderEntries(shaders),
        mode: InsertMode.insertOrReplace));
  }

  /// Deletes a [Shader] by [shaderId]
  ///
  /// * [shaderId]: The id of the [Shader]
  Future<void> deleteById(String shaderId) {
    return (delete(shaderTable)..where((shader) => shader.id.equals(shaderId)))
        .go();
  }
}
