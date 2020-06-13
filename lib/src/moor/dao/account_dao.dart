import 'package:enum_to_string/enum_to_string.dart';
import 'package:moor/moor.dart';
import 'package:shadertoy_api/shadertoy_api.dart';
import 'package:shadertoy_moor/src/moor/store.dart';
import 'package:shadertoy_moor/src/moor/table/account_table.dart';

part 'account_dao.g.dart';

@UseDao(tables: [AccountTable])
class AccountDao extends DatabaseAccessor<MoorStore> with _$AccountDaoMixin {
  AccountDao(MoorStore store) : super(store);

  Account _toEntity(AccountEntry entry) {
    return entry != null
        ? Account(
            name: entry.name,
            type: EnumToString.fromString(AccountType.values, entry.type),
            system: entry.system,
            credentials: entry.password,
            displayName: entry.displayName,
            picture: entry.picture)
        : null;
  }

  AccountEntry _toEntry(Account entity) {
    return AccountEntry(
        name: entity.name,
        type: EnumToString.parse(entity.type),
        system: entity.system,
        password: entity.credentials,
        displayName: entity.displayName,
        picture: entity.picture);
  }

  Future<Account> findById(String accountId) {
    return (select(accountTable)..where((t) => t.name.equals(accountId)))
        .getSingle()
        .then(_toEntity);
  }

  Future<List<AccountEntry>> _getAccountQuery(
      {String name, AccountType type, bool system}) async {
    var hasName = name != null && name.isNotEmpty;
    var hasType = type != null;
    var hasSystem = system != null;

    final query = select(accountTable);
    if (hasName || hasType || hasSystem) {
      query.where((entry) {
        var exp;

        if (hasName) {
          var nameExp = entry.name.equals(name);
          exp = (exp == null ? nameExp : exp & nameExp);
        }

        if (hasType) {
          var typeExp = entry.type.equals(EnumToString.parse(type));
          exp = (exp == null ? typeExp : exp & typeExp);
        }

        if (hasSystem) {
          var systemExp = entry.system.equals(system);
          exp = (exp == null ? systemExp : exp & systemExp);
        }

        return exp;
      });
    }

    return query.get();
  }

  List<Account> _toEntities(List<AccountEntry> entries) {
    return entries.map(_toEntity);
  }

  Future<List<Account>> find(
      {String name, AccountType type, bool system}) async {
    return _getAccountQuery(name: name, type: type, system: system)
        .then(_toEntities);
  }

  Future<int> save(Account account) {
    return into(accountTable).insert(_toEntry(account), orReplace: true);
  }
}
