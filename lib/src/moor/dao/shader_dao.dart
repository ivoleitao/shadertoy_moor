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
class ShaderDao extends DatabaseAccessor<MoorStore> with _$ShaderDaoMixin {
  ShaderDao(MoorStore store) : super(store);

  Info _toInfoEntity(ShaderEntry entry) {
    return Info(
        id: entry.id,
        date: entry.date,
        views: entry.views,
        name: entry.name,
        userId: entry.userId,
        description: entry.description,
        likes: entry.likes,
        publishStatus:
            EnumToString.fromString(PublishStatus.values, entry.publishStatus),
        flags: entry.flags,
        tags: (jsonDecode(entry.tagsJson) as List<dynamic>).cast<String>(),
        hasLiked: entry.liked);
  }

  Shader _toShaderEntity(ShaderEntry entry) {
    return entry != null
        ? Shader(
            version: entry.version,
            info: _toInfoEntity(entry),
            renderPasses: (jsonDecode(entry.renderPassesJson) as List<dynamic>)
                .cast<RenderPass>())
        : null;
  }

  Future<bool> exists(String shaderId) async {
    return (select(shaderTable)..where((entry) => entry.id.equals(shaderId)))
            .getSingle() !=
        null;
  }

  Future<Shader> findById(String shaderId) async {
    return (select(shaderTable)..where((entry) => entry.id.equals(shaderId)))
        .getSingle()
        .then(_toShaderEntity);
  }

  Future<List<String>> findAllIds() async {
    return shaderId().get();
  }

  Future<List<ShaderEntry>> _getQuery(
      {String term,
      String userId,
      Set<String> tags,
      Sort sort,
      int from,
      int num}) async {
    var hasTerm = term != null && term.isNotEmpty;
    var hasUserId = userId != null && userId.isEmpty;
    var hasTags = tags != null && tags.isNotEmpty;

    final query = select(shaderTable);
    if (hasTerm || hasUserId || hasTags) {
      query.where((entry) {
        var exp;

        if (hasTerm) {
          var termExp = entry.name.like(term);
          exp = (exp == null ? termExp : exp & termExp);
        }

        if (hasUserId) {
          var userExp = entry.userId.equals(userId);
          exp = (exp == null ? userExp : exp & userExp);
        }

        if (hasTags) {
          var tagsExp;
          for (var tag in tags) {
            if (tagsExp == null) {
              tagsExp = entry.tagsJson.like('%${tag}%');
            } else {
              tagsExp = tagsExp | entry.tagsJson.like('%${tag}%');
            }
          }

          exp = (exp == null ? tagsExp : exp & tagsExp);
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
              expression: shaderTable.likes, mode: OrderingMode.desc)
      ]);
    }

    from ??= 0;
    num ??= -1;
    if (from > 0 || num > 0) {
      query.limit(num, offset: from);
    }

    return query.get();
  }

  List<String> _toShaderIds(List<ShaderEntry> entries) {
    return entries.map((ShaderEntry entry) => entry.id);
  }

  Future<List<String>> findIdsByTerm(
      {String term, Set<String> filters, Sort sort, int from, int num}) async {
    return _getQuery(
            term: term, tags: filters, sort: sort, from: from, num: num)
        .then(_toShaderIds);
  }

  Future<List<String>> findIdsByUser(
      {String userId,
      Set<String> filters,
      Sort sort,
      int from,
      int num}) async {
    return _getQuery(
            userId: userId, tags: filters, sort: sort, from: from, num: num)
        .then(_toShaderIds);
  }

  List<Shader> _toEntities(List<ShaderEntry> entries) {
    return entries.map(_toShaderEntity);
  }

  Future<List<Shader>> findByTerm(
      {String term, Set<String> filters, Sort sort, int from, int num}) async {
    return _getQuery(
            term: term, tags: filters, sort: sort, from: from, num: num)
        .then(_toEntities);
  }

  Future<List<Shader>> findByUser(
      {String userId,
      Set<String> filters,
      Sort sort,
      int from,
      int num}) async {
    return _getQuery(
            userId: userId, tags: filters, sort: sort, from: from, num: num)
        .then(_toEntities);
  }

  Future<List<ShaderEntry>> _getShaderPlaylistQuery(String playlistId,
      {int from, int num}) async {
    final query = select(shaderTable).join([
      innerJoin(playlistShaderTable,
          playlistShaderTable.shaderId.equalsExp(shaderTable.id))
    ]);

    from ??= 0;
    num ??= -1;
    if (from > 0 || num > 0) {
      query.limit(num, offset: from);
    }

    return query.get().then(
        (results) => results.map((tr) => tr.readTable(shaderTable)).toList());
  }

  Future<List<String>> findIdsByPlaylist(String playlistId,
      {int from, int num}) async {
    return _getShaderPlaylistQuery(playlistId, from: from, num: num)
        .then(_toShaderIds);
  }

  Future<List<Shader>> findByPlaylist(String playlistId,
      {int from, int num}) async {
    return _getShaderPlaylistQuery(playlistId, from: from, num: num)
        .then(_toEntities);
  }

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
        publishStatus: EnumToString.parse(entity.info.publishStatus),
        flags: entity.info.flags,
        tagsJson: json.encode(entity.info.tags),
        liked: entity.info.hasLiked,
        renderPassesJson: json.encode(
            entity.renderPasses.map((RenderPass rp) => rp.toJson()).toList()));
  }

  Future<void> save(Shader shader) {
    return into(shaderTable)
        .insert(_toShaderEntry(shader), mode: InsertMode.insertOrReplace);
  }
}
