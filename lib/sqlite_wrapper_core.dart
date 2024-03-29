library sqlite_wrapper;

// ignore: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:sqlite3/sqlite3.dart';

const String inMemoryDatabasePath = ':memory:';

typedef FromMap = dynamic Function(Map<String, dynamic> map);

typedef OnUpgrade = Future<void> Function(int fromVersion, int toVersion);

typedef OnCreate = Future<void> Function();

const defaultDBName = "mainDB";

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

class SQLiteWrapperCore {
  static final List<StreamInfo> streams = [];
  static final _dbs = {};
  bool debugMode = false;

  /// Open the Database and returns true if the Database has been created
  Future<DatabaseInfo> openDB(String path,
      {int version = 0,
      OnCreate? onCreate,
      OnUpgrade? onUpgrade,
      String? dbName}) async {
    dbName ??= defaultDBName;
    bool missingDB = true;
    if (path == inMemoryDatabasePath) {
      _dbs[dbName] = sqlite3.openInMemory();
    } else {
      final File f = File(path);
      missingDB = !f.existsSync();
      if (missingDB) {
        // Create the path to the DB file if it's missing
        var dir = Directory.fromUri(Uri.directory(path));
        if (!dir.parent.existsSync()) {
          dir.parent.createSync(recursive: true);
        }
      }
      _dbs[dbName] = sqlite3.open(path);
      if (debugMode) {
        // ignore: avoid_print
        print("DB location: ${_dbs[dbName]}");
      }
    }
    // Execute the onCreate method if is set
    if (missingDB && onCreate != null) {
      await onCreate();
    }
    // Execute the onUpdate method if the version is set
    int currentVersion = await getVersion(dbName: dbName);
    if (onUpgrade != null && version != currentVersion) {
      await onUpgrade(currentVersion, version);
    }
    // Set the version
    if (version != currentVersion) {
      await setVersion(version, dbName: dbName);
    }
    return DatabaseInfo(
        path: path,
        created: missingDB,
        version: version,
        dbName: dbName,
        sqliteVersion: sqlite3.version.toString());
  }

  /// Close the Database
  void closeDB({String? dbName}) {
    _dbs[dbName ?? defaultDBName].dispose();
    _dbs.remove(dbName ?? defaultDBName);
  }

  /// Database accessible from outside (map the internal db instance)
  Database getDatabase({String? dbName}) {
    return _dbs[dbName ?? defaultDBName];
  }

  /// Executes an SQL Query with no return value
  /// params - an optional list of parameters to pass to the query
  /// tables - an optional list of tables affected by the query
  Future<dynamic>? execute(String sql,
      {List<String>? tables,
      List<Object?> params = const [],
      String? dbName}) async {
    if (debugMode) {
      // ignore: avoid_print
      print("execute: $sql - params: $params - tables: $tables");
    }
    final String sqlCommand = sql.substring(0, sql.indexOf(" ")).toUpperCase();
    final db = _getDB(dbName);
    switch (sqlCommand) {
      case "INSERT":
        // Return the ID of last inserted row
        db.execute(sql, params);
        updateStreams(tables);
        return db.lastInsertRowId;
      case "UPDATE":
        // Return number of changes made
        db.execute(sql, params);
        updateStreams(tables);
        return db.getUpdatedRows();
      case "DELETE":
        // Return number of changes made
        db.execute(sql, params);
        updateStreams(tables);
        return db.getUpdatedRows();
      default:
        return db.execute(sql, params);
    }
  }

  /// Executes an SQL Query that return a single value
  /// params - an optional list of parameters to pass to the query
  /// fromMap - a function that convert the result map to the returned object
  /// singleResult - return an object instead of a list of objects
  Future<dynamic> query(String sql,
      {List<Object?> params = const [],
      FromMap? fromMap,
      bool singleResult = false,
      String? dbName}) async {
    final List<Map> results = _getDB(dbName).select(sql, params);
    if (singleResult) {
      if (results.isEmpty) {
        return null;
      }
      // Single results
      final Map<String, dynamic> result = results.first as Map<String, dynamic>;
      // If only a column has been extracted return the simple object
      if (result.keys.length == 1) {
        return result[result.keys.first];
      }
      if (fromMap != null) {
        // The fromMap method converts the Map to the returned object
        try {
          final map = result;
          //  _rowToMap(result);
          return fromMap(map);
        } catch (error) {
          // ignore: avoid_print
          print(error.toString());
        }
      }
      return result;
    }
    // Multiple results
    // Return just a simple field object
    if (results.isNotEmpty && results.first.keys.length == 1) {
      final String onlyField = results.first.keys.first;
      return results.map((e) => e[onlyField]).toList();
    }
    if (fromMap != null) {
      return results
          .map((map) => fromMap(map as Map<String, dynamic>))
          .toList();
    }
    // Return a list of Map
    return results;
  }

  Future<int> update(Map<String, dynamic> map, String table,
      {required List<String> keys, String? dbName}) async {
    //VALUES
    String updateClause = "";
    final List params = [];
    final values = map.keys.where((element) => !keys.contains(element));
    for (String value in values) {
      if (updateClause.isNotEmpty) updateClause += ", ";
      updateClause += "$value=?";
      params.add(map[value]);
    }
    // KEYS
    String whereClause = _getWhereClause(keys, params, map);

    final String sql = "UPDATE $table SET $updateClause WHERE $whereClause";
    final res =
        await execute(sql, tables: [table], params: params, dbName: dbName);
    return res;
  }

  /// Create the where clause for the update or delete sql
  String _getWhereClause(
      List<String> keys, List<dynamic> params, Map<String, dynamic> map) {
    String whereClause = "";
    for (String key in keys) {
      if (whereClause.isNotEmpty) whereClause += " AND ";
      whereClause += "$key=?";
      params.add(map[key]);
    }
    return whereClause;
  }

  /// Insert a new record in the passed table based on the map object
  /// and return the new id
  Future<int> insert(Map<String, dynamic> map, String table,
      {String? dbName}) async {
    return _insertOrUpdate(map, table, dbName: dbName);
  }

  // Perform an INSERT or an UPDATE depending on the record state (UPSERT)
  Future<int> save(Map<String, dynamic> map, String table,
      {List<String>? keys, String? dbName}) async {
    return _insertOrUpdate(map, table, keys: keys, dbName: dbName);
  }

  /// Method called internally to perform an insert or to perform an UPSERT
  /// if a keys list is provided
  /// (if a value is already present is performed an update instead of an insert)
  Future<int> _insertOrUpdate(Map<String, dynamic> map, String table,
      {List<String>? keys, String? dbName}) async {
    //VALUES
    String insertClause = "";
    String insertValues = "";
    List params = [];

    for (String value in map.keys) {
      if (insertClause.isNotEmpty) {
        insertClause += ", ";
        insertValues += ", ";
      }
      insertClause += value;
      insertValues += "?";
      params.add(map[value]);
    }
    String sql = "INSERT INTO $table ($insertClause) VALUES ($insertValues)";
    // CREATE AN UPSERT
    if (keys != null) {
      final keysValue = keys.join(", ");
      String updateClause = "";
      final values = map.keys.where((element) => !keys.contains(element));
      for (String value in values) {
        if (updateClause.isNotEmpty) updateClause += ", ";
        updateClause += "$value=?";
        params.add(map[value]);
      }
      sql = "$sql ON CONFLICT ($keysValue) DO UPDATE SET $updateClause";
    }
    final int res =
        await execute(sql, tables: [table], params: params, dbName: dbName);
    return res;
  }

  /// DELETE the item building the SQL query using the table and the id passed
  Future<int> delete(Map<String, dynamic> map, String table,
      {required List<String> keys, String? dbName}) async {
    final List params = [];
    // KEYS
    String whereClause = _getWhereClause(keys, params, map);
    final String sql = "DELETE FROM $table WHERE $whereClause";
    final res =
        await execute(sql, tables: [table], params: params, dbName: dbName);
    return res;
  }

  /// Executes an SQL Query that return a single value
  /// params - an optional list of parameters to pass to the query
  /// fromMap - a function that convert the result map to the returned object
  /// singleResult - return an object instead of a list of objects
  Stream watch(String sql,
      {List<Object?> params = const [],
      FromMap? fromMap,
      bool singleResult = false,
      required List<String> tables,
      String? dbName}) {
    final StreamController sc = StreamController();
    // Initial values
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
    // Remove from list of streams
    sc.done.then((value) => streams.remove(streamInfo));
    return sc.stream;
  }

  /// Reload data in stream emitting the new result
  Future<void> _updateStream(StreamInfo streamInfo) async {
    dynamic results = await query(streamInfo.sql,
        params: streamInfo.params,
        singleResult: streamInfo.singleResult,
        fromMap: streamInfo.fromMap,
        dbName: streamInfo.dbName);
    streamInfo.controller.add(results);
  }

  /// Update all the streams connected to one of the table in the list
  Future<void> updateStreams(List<String>? tables) async {
    if (tables == null || tables.isEmpty) return;
    for (StreamInfo s in streams) {
      for (String table in tables) {
        if (s.tables.contains(table)) {
          await _updateStream(s);
          continue;
        }
      }
    }
  }

  Future<int> getVersion({String? dbName}) async {
    return await query("PRAGMA user_version;",
        singleResult: true, dbName: dbName);
  }

  Future<void> setVersion(int version, {String? dbName}) async {
    await execute("PRAGMA user_version=$version;", dbName: dbName);
  }

  // Return the database instance with the passed name
  Database _getDB(String? dbName) {
    assert(_dbs.isNotEmpty, "It seems the openDB method has not been called!");
    return _dbs[dbName ?? defaultDBName];
  }
}
