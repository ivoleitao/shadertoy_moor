import 'package:enum_to_string/enum_to_string.dart';
import 'package:moor/moor.dart';
import 'package:shadertoy_api/shadertoy_api.dart';
import 'package:shadertoy_moor/src/moor/dao/account_dao.dart';
import 'package:shadertoy_moor/src/moor/dao/comment_dao.dart';
import 'package:shadertoy_moor/src/moor/dao/playlist_dao.dart';
import 'package:shadertoy_moor/src/moor/store_options.dart';
import 'package:shadertoy_moor/src/moor/table/comment_table.dart';
import 'package:shadertoy_moor/src/moor/table/playlist_shader_table.dart';
import 'package:shadertoy_moor/src/moor/table/playlist_table.dart';
import 'package:shadertoy_moor/src/moor/table/shader_table.dart';

import 'dao/account_dao.dart';
import 'dao/shader_dao.dart';
import 'dao/user_dao.dart';
import 'table/account_table.dart';
import 'table/user_table.dart';

part 'store.g.dart';

@UseMoor(tables: [
  UserTable,
  AccountTable,
  ShaderTable,
  CommentTable,
  PlaylistTable,
  PlaylistShaderTable
], daos: [
  UserDao,
  AccountDao,
  AccountDao,
  ShaderDao,
  CommentDao,
  PlaylistDao
])
class MoorStore extends _$MoorStore {
  static const int SchemaVersion = 1;

  final MoorStoreOptions options;

  static MoorStore _instance;

  MoorStore._(this.options)
      : assert(options != null),
        super(options.executor);

  factory MoorStore(MoorStoreOptions options) {
    return _instance ?? MoorStore._(options);
  }

  static MoorStore get instance => _instance;

  @override
  int get schemaVersion => SchemaVersion;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(beforeOpen: (details) async {
      if (details.wasCreated && options.accounts.isNotEmpty) {
        await batch((b) => b.insertAll(
            accountTable,
            options.accounts
                .map((Account account) => AccountEntry(
                    name: account.name,
                    type: EnumToString.parse(account.type),
                    system: account.system,
                    password: account.credentials,
                    displayName: account.displayName,
                    picture: account.picture))
                .toList()));
      }
      await customStatement('PRAGMA foreign_keys = ON;');
    });
  }
}
