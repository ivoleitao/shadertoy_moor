import 'package:moor/moor.dart';
import 'package:shadertoy_api/shadertoy_api.dart';
import 'package:shadertoy_moor/src/moor/store.dart';
import 'package:shadertoy_moor/src/moor/table/user_table.dart';

part 'user_dao.g.dart';

@UseDao(tables: [UserTable])
class UserDao extends DatabaseAccessor<MoorStore> with _$UserDaoMixin {
  UserDao(MoorStore store) : super(store);

  User _toEntity(UserEntry entry) {
    return entry != null
        ? User(
            id: entry.id,
            picture: entry.picture,
            memberSince: entry.memberSince,
            shaders: entry.shaders,
            comments: entry.comments,
            about: entry.about)
        : null;
  }

  UserEntry _toEntry(User entity) {
    return UserEntry(
        id: entity.id,
        picture: entity.picture,
        memberSince: entity.memberSince,
        shaders: entity.shaders,
        comments: entity.comments,
        about: entity.about);
  }

  Future<User> findById(String userId) {
    return (select(userTable)..where((t) => t.id.equals(userId)))
        .getSingle()
        .then(_toEntity);
  }

  Future<int> save(User user) {
    return into(userTable).insert(_toEntry(user), orReplace: true);
  }
}
