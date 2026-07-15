import 'dart:async';

const String inMemoryDatabasePath = ':memory:';

typedef FromMap = dynamic Function(Map<String, dynamic> map);

typedef OnUpgrade = Future<void> Function(int fromVersion, int toVersion);

typedef OnCreate = Future<void> Function();

const defaultDBName = "mainDB";

/// Unified async interface for all database backends.
///
/// Each platform (native sqlite3, sqflite_ffi_web, gRPC) implements this
/// interface to normalize access behind a single type.
abstract class DatabaseCore {
  Future<void> execute(String sql, List<Object?> params);

  Future<List<Map<String, dynamic>>> select(
      String sql, List<Object?> params);

  void close();
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

/// Manages multiple named database connections.
/// Maps [dbName] strings to [DatabaseCore] instances.
class Databases {
  final Map<String, DatabaseCore> _dbs = {};
  final Set<String> _grcpsDBs = {};

  void add(
      {required String name, required DatabaseCore db, bool useGRPC = false}) {
    _dbs[name] = db;
    if (useGRPC) {
      _grcpsDBs.add(name);
    }
  }

  DatabaseCore? get(String name) {
    return _dbs[name];
  }

  void remove(String name) {
    _dbs.remove(name);
    _grcpsDBs.remove(name);
  }

  bool get isNotEmpty {
    return _dbs.isNotEmpty;
  }

  /// Return all db names
  List<String> getNames() {
    return _dbs.keys.map((item) => item.toString()).toList();
  }

  bool useGRPC(String name) {
    return _grcpsDBs.contains(name);
  }
}
