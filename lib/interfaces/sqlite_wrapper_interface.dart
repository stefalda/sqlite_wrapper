import 'package:sqlite_wrapper/sqlite_wrapper_types.dart';

abstract class SqliteWrapperInterface {
  Future<DatabaseInfo> openDB(
    String path, {
    int version = 0,
    OnCreate? onCreate,
    OnUpgrade? onUpgrade,
    String? dbName,
    bool useGRPC = false,
  });

  Future<void> closeDB({String? dbName});

  DatabaseCore? getDatabase({String? dbName});

  Future<dynamic> execute(String sql,
      {List<String>? tables, List<Object?> params = const [], String? dbName});

  Future<int> getVersion({String? dbName});

  Future<void> setVersion(int version, {String? dbName});
}
