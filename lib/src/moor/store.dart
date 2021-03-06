import 'package:moor/moor.dart';
import 'package:shadertoy_moor/src/moor/dao/comment_dao.dart';
import 'package:shadertoy_moor/src/moor/dao/playlist_dao.dart';
import 'package:shadertoy_moor/src/moor/table/comment_table.dart';
import 'package:shadertoy_moor/src/moor/table/playlist_shader_table.dart';
import 'package:shadertoy_moor/src/moor/table/playlist_table.dart';
import 'package:shadertoy_moor/src/moor/table/shader_table.dart';

import 'dao/shader_dao.dart';
import 'dao/user_dao.dart';
import 'table/user_table.dart';

part 'store.g.dart';

@UseMoor(tables: [
  UserTable,
  ShaderTable,
  CommentTable,
  PlaylistTable,
  PlaylistShaderTable
], daos: [
  UserDao,
  ShaderDao,
  CommentDao,
  PlaylistDao
])

/// The Moor storage abstraction
class MoorStore extends _$MoorStore {
  /// The current schema version
  static const int SchemaVersion = 1;

  /// Creates a [MoorStore]
  ///
  /// * [executor]: The selected [QueryExecutor]
  MoorStore(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => SchemaVersion;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(beforeOpen: (details) async {
      if (details.wasCreated) {}
      await customStatement('PRAGMA foreign_keys = ON;');
    });
  }
}
