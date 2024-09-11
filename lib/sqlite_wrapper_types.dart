import 'dart:async';

const String inMemoryDatabasePath = ':memory:';

typedef FromMap = dynamic Function(Map<String, dynamic> map);

typedef OnUpgrade = Future<void> Function(int fromVersion, int toVersion);

typedef OnCreate = Future<void> Function();

const defaultDBName = "mainDB";

abstract class DatabaseCore {
  void execute(String sql, List<Object?> params);

  List<Map> select(String sql, List<Object?> params);
  void dispose();
}

class DatabaseInfo {
  final String path;
  final bool created;
  final int version;
  final String sqliteVersion;
  final String dbName;

  DatabaseInfo(
      {required this.path,
      required this.created,
      required this.version,
      required this.sqliteVersion,
      required this.dbName});
}

class StreamInfo {
  String sql;
  List<String> tables;
  StreamController controller;
  List<Object?> params;
  FromMap? fromMap;
  bool singleResult;
  String dbName;
  StreamInfo(
      {required this.sql,
      required this.tables,
      required this.controller,
      this.params = const [],
      this.fromMap,
      required this.dbName,
      this.singleResult = false});
}

class Databases {
  final _dbs = {};

  void add({required String name, required db}) {
    _dbs[name] = db;
  }

  dynamic get(String name) {
    return _dbs[name];
  }

  void remove(String name) {
    _dbs.remove(name);
  }

  bool get isNotEmpty {
    return _dbs.isNotEmpty;
  }
}
