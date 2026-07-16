import 'dart:async';

import 'package:sqlite_wrapper/sqlite_wrapper_types.dart';

import './helpers/platform/platform.dart';

/// Validates a column name to prevent SQL injection.
/// Accepts only identifiers matching `^[a-zA-Z_][a-zA-Z0-9_]*$`.
String sanitizeColumnName(String name) {
  if (!RegExp(r'^[a-zA-Z_][a-zA-Z0-9_]*$').hasMatch(name)) {
    throw ArgumentError('Invalid column name: $name');
  }
  return name;
}

abstract class SQLiteWrapperBase {
  final List<StreamInfo> streams = [];
  final Databases databases = Databases();

  bool debugMode = false;

  bool isWeb() {
    return isRunningOnWeb();
  }

  /// Open the Database and returns [DatabaseInfo] with creation status and version.
  Future<DatabaseInfo> openDB(
    String path, {
    int version = 0,
    OnCreate? onCreate,
    OnUpgrade? onUpgrade,
    String? dbName,
    bool useGRPC = false,
  });

  /// Close the Database and clean up its streams.
  Future<void> closeDB({String? dbName}) async {
    final resolvedName = dbName ?? defaultDBName;
    final db = databases.get(resolvedName);
    db?.close();
    databases.remove(resolvedName);
    streams.removeWhere((s) => s.dbName == resolvedName);
  }

  /// Returns the internal [DatabaseCore] instance for the given db name.
  /// Handle with care: exposes the underlying database adapter.
  DatabaseCore? getDatabase({String? dbName}) {
    return databases.get(dbName ?? defaultDBName);
  }

  /// Expose the databases object.
  Databases getDatabases() {
    return databases;
  }

  /// Convert booleans to integers (true=1, false=0) in a new list.
  /// Does not mutate the original [params] list.
  List<Object?> fixBoolParams(List<Object?> params) {
    return params.map((p) {
      if (p is bool) return p ? 1 : 0;
      return p;
    }).toList();
  }

  /// Validates column names in [keys] for SQL safety.
  void _validateKeys(List<String> keys) {
    for (final key in keys) {
      sanitizeColumnName(key);
    }
  }

  /// Executes an SQL statement.
  ///
  /// Returns different results based on the operation:
  /// - INSERT: the last inserted row id
  /// - UPDATE: the number of affected rows
  /// - DELETE: the number of affected rows
  /// - other: the result of the statement
  ///
  /// [tables] is used by the reactive stream system to know which watched
  /// queries to refresh after this operation.
  Future<dynamic> execute(String sql,
      {List<String>? tables,
      List<Object?> params = const [],
      String? dbName}) async {
    if (debugMode) {
      // ignore: avoid_print
      print("execute: $sql - params: $params - tables: $tables");
    }
    final String sqlCommand = sql.contains(" ")
        ? sql.substring(0, sql.indexOf(" ")).toUpperCase()
        : sql;
    final db = _getDB(dbName);
    final resolvedParams = fixBoolParams(params);
    try {
      switch (sqlCommand) {
        case "INSERT":
          await db.execute(sql, resolvedParams);
          return await query("SELECT last_insert_rowid()",
              dbName: dbName, singleResult: true);
        case "UPDATE":
          await db.execute(sql, resolvedParams);
          return await query("SELECT changes()",
              dbName: dbName, singleResult: true);
        case "DELETE":
          await db.execute(sql, resolvedParams);
          return await query("SELECT changes()",
              dbName: dbName, singleResult: true);
        default:
          return await db.execute(sql, resolvedParams);
      }
    } finally {
      await updateStreams(tables);
    }
  }

  /// Executes a query and returns the results.
  ///
  /// Returns a [List] of results, or a single result if [singleResult] is true.
  /// When [fromMap] is provided, results are converted via that function.
  /// When the query returns a single column, only that column's values are returned.
  Future<dynamic> query(String sql,
      {List<Object?> params = const [],
      FromMap? fromMap,
      bool singleResult = false,
      String? dbName}) async {
    dbName ??= defaultDBName;
    final db = _getDB(dbName);
    final resolvedParams = fixBoolParams(params);
    final results = await db.select(sql, resolvedParams);
    if (singleResult) {
      if (results.isEmpty) {
        return null;
      }
      final Map<String, dynamic> result = results.first;
      if (result.keys.length == 1) {
        return result[result.keys.first];
      }
      if (fromMap != null) {
        return fromMap(result);
      }
      return result;
    }
    if (results.isNotEmpty && results.first.keys.length == 1) {
      final String onlyField = results.first.keys.first;
      return results.map((e) => e[onlyField]).toList();
    }
    if (fromMap != null) {
      return results.map((map) => fromMap(map)).toList();
    }
    return results;
  }

  /// Update a row identified by [keys] with values from [map].
  /// Returns the number of affected rows.
  Future<int> update(Map<String, dynamic> map, String table,
      {required List<String> keys, String? dbName}) async {
    _validateKeys(keys);
    String updateClause = "";
    final List<Object?> params = [];
    final values = map.keys.where((element) => !keys.contains(element));
    for (String value in values) {
      if (updateClause.isNotEmpty) updateClause += ", ";
      updateClause += "${sanitizeColumnName(value)}=?";
      params.add(map[value]);
    }
    String whereClause = _getWhereClause(keys, params, map);
    final String sql = "UPDATE $table SET $updateClause WHERE $whereClause";
    final res =
        await execute(sql, tables: [table], params: params, dbName: dbName);
    return res;
  }

  /// Build the WHERE clause from [keys] and populate [params].
  String _getWhereClause(
      List<String> keys, List<Object?> params, Map<String, dynamic> map) {
    String whereClause = "";
    for (String key in keys) {
      if (whereClause.isNotEmpty) whereClause += " AND ";
      whereClause += "${sanitizeColumnName(key)}=?";
      params.add(map[key]);
    }
    return whereClause;
  }

  /// Insert a new record from [map] into [table].
  /// Returns the new row id.
  Future<int> insert(Map<String, dynamic> map, String table,
      {String? dbName}) async {
    return _insertOrUpdate(map, table, dbName: dbName);
  }

  /// Insert or update depending on whether a row with the same key exists (UPSERT).
  /// Returns the row id.
  Future<int> save(Map<String, dynamic> map, String table,
      {List<String>? keys, String? dbName}) async {
    return _insertOrUpdate(map, table, keys: keys, dbName: dbName);
  }

  /// Internal method: INSERT or UPSERT when [keys] is provided.
  Future<int> _insertOrUpdate(Map<String, dynamic> map, String table,
      {List<String>? keys, String? dbName}) async {
    if (keys != null) _validateKeys(keys);
    String insertClause = "";
    String insertValues = "";
    List<Object?> params = [];
    for (String value in map.keys) {
      if (insertClause.isNotEmpty) {
        insertClause += ", ";
        insertValues += ", ";
      }
      insertClause += sanitizeColumnName(value);
      insertValues += "?";
      params.add(map[value]);
    }
    String sql = "INSERT INTO $table ($insertClause) VALUES ($insertValues)";
    if (keys != null) {
      final keysValue = keys.map(sanitizeColumnName).join(", ");
      String updateClause = "";
      final values = map.keys.where((element) => !keys.contains(element));
      for (String value in values) {
        if (updateClause.isNotEmpty) updateClause += ", ";
        updateClause += "${sanitizeColumnName(value)}=?";
        params.add(map[value]);
      }
      sql = "$sql ON CONFLICT ($keysValue) DO UPDATE SET $updateClause";
    }
    final int res =
        await execute(sql, tables: [table], params: params, dbName: dbName);
    return res;
  }

  /// Delete rows matching [keys] from [map].
  /// Returns the number of deleted rows.
  Future<int> delete(Map<String, dynamic> map, String table,
      {required List<String> keys, String? dbName}) async {
    _validateKeys(keys);
    final List<Object?> params = [];
    String whereClause = _getWhereClause(keys, params, map);
    final String sql = "DELETE FROM $table WHERE $whereClause";
    final res =
        await execute(sql, tables: [table], params: params, dbName: dbName);
    return res;
  }

  /// Returns a [Stream] that emits results of [sql] whenever [tables] change.
  ///
  /// The stream automatically re-queries the database after any `execute` call
  /// that touches one of the watched [tables].
  Stream watch(String sql,
      {List<Object?> params = const [],
      FromMap? fromMap,
      bool singleResult = false,
      required List<String> tables,
      String? dbName}) {
    final StreamController sc = StreamController();
    final StreamInfo streamInfo = StreamInfo(
        controller: sc,
        sql: sql,
        tables: tables,
        params: params,
        fromMap: fromMap,
        dbName: dbName ?? defaultDBName,
        singleResult: singleResult);
    streams.add(streamInfo);
    _updateStream(streamInfo);
    sc.done.then((value) => streams.remove(streamInfo));
    return sc.stream;
  }

  /// Re-run the query and emit updated results to the stream.
  Future<void> _updateStream(StreamInfo streamInfo) async {
    dynamic results = await query(streamInfo.sql,
        params: streamInfo.params,
        singleResult: streamInfo.singleResult,
        fromMap: streamInfo.fromMap,
        dbName: streamInfo.dbName);
    streamInfo.controller.add(results);
  }

  /// Refresh streams that watch any of the [tables].
  /// If [tables] is null, all streams are refreshed.
  Future<void> updateStreams(List<String>? tables) async {
    // Snapshot per evitare ConcurrentModificationError:
    // streams può essere modificato durante gli await (es. nuova watch o
    // sc.done che rimuove un elemento), e Dart lancia l'eccezione se
    // si modifica una lista mentre la si itera con for...in.
    final snapshot = List<StreamInfo>.from(streams);
    if (tables == null) {
      for (StreamInfo s in snapshot) {
        await _updateStream(s);
      }
      return;
    }
    if (tables.isEmpty) return;
    for (StreamInfo s in snapshot) {
      for (String table in tables) {
        if (s.tables.contains(table)) {
          await _updateStream(s);
          continue;
        }
      }
    }
  }

  /// Execute [action] inside a database transaction.
  ///
  /// On success: commits the transaction and refreshes all streams.
  /// On error: rolls back, does NOT refresh streams, and rethrows the exception.
  /// Nested transactions are not supported and throw [StateError].
  Future<T> transaction<T>(Future<T> Function() action,
      {String? dbName}) async {
    final db = _getDB(dbName);
    await db.execute("BEGIN", []);
    try {
      final result = await action();
      await db.execute("COMMIT", []);
      await updateStreams(null);
      return result;
    } catch (e) {
      await db.execute("ROLLBACK", []);
      rethrow;
    }
  }

  Future<int> getVersion({String? dbName}) async {
    return await query("PRAGMA user_version;",
        singleResult: true, dbName: dbName);
  }

  Future<void> setVersion(int version, {String? dbName}) async {
    await execute("PRAGMA user_version=$version;", dbName: dbName);
  }

  /// Returns the [DatabaseCore] instance for the given db name.
  /// Throws an assertion error if [openDB] has not been called.
  DatabaseCore _getDB(String? dbName) {
    assert(databases.isNotEmpty,
        "It seems the openDB method has not been called!");
    final db = databases.get(dbName ?? defaultDBName);
    assert(db != null, "Database '$dbName' not found. Did you call openDB?");
    return db!;
  }
}
