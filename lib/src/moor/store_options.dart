import 'package:moor/moor.dart';
import 'package:shadertoy_api/shadertoy_api.dart';

class MoorStoreOptions {
  final QueryExecutor executor;
  final List<Account> accounts;

  MoorStoreOptions(this.executor, {this.accounts = const []})
      : assert(executor != null),
        assert(accounts != null);
}
