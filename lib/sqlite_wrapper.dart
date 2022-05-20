library sqlite_wrapper;

// ignore: depend_on_referenced_packages

import 'dart:async';

import 'package:sqlite3/sqlite3.dart';

const String inMemoryDatabasePath = ':memory:';

typedef FromMap = dynamic Function(Map<String, dynamic> map);

class StreamInfo {
  String sql;
  List<String> tables;
  StreamController controller;
  List<Object?> params;
  FromMap? fromMap;
  bool singleResult;
  StreamInfo(
      {required this.sql,
      required this.tables,
      required this.controller,
      this.params = const [],
      this.fromMap,
      this.singleResult = false});
}

class SQLiteWrapper {
  static final SQLiteWrapper _singleton = SQLiteWrapper._internal();
  static final List<StreamInfo> streams = [];
  bool debugMode = false;

  late Database _db;

  factory SQLiteWrapper() {
    // print('Using sqlite3 ${sqlite3.version}');
    return _singleton;
  }

  SQLiteWrapper._internal();

  /// Open the Database
  void openDB(String path) {
    if (path == inMemoryDatabasePath) {
      _db = sqlite3.openInMemory();
      return;
    }
    _db = sqlite3.open(path);
    if (debugMode) {
      // ignore: avoid_print
      print("DB location: $_db");
    }
  }

  /// Close the Database
  void closeDB() {
    return _db.dispose();
  }

  /// Database accessible from outside (map the internal _db variable)
  get database {
    return _db;
  }

  /// Executes an SQL Query with no return value
  /// params - an optional list of parameters to pass to the query
  /// tables - an optional list of tables affected by the query
  Future<dynamic>? execute(String sql,
      {List<String>? tables, List<Object?> params = const []}) async {
    if (debugMode) {
      // ignore: avoid_print
      print("execute: $sql - params: $params - tables: $tables");
    }
    final String sqlCommand = sql.substring(0, sql.indexOf(" ")).toUpperCase();
    switch (sqlCommand) {
      case "INSERT":
        // Return the ID of last inserted row
        _db.execute(sql, params);
        _updateStreams(tables);
        return _db.lastInsertRowId;
      case "UPDATE":
        // Return number of changes made
        _db.execute(sql, params);
        _updateStreams(tables);
        return _db.getUpdatedRows();
      case "DELETE":
        // Return number of changes made
        _db.execute(sql, params);
        _updateStreams(tables);
        return _db.getUpdatedRows();
      default:
        return _db.execute(sql, params);
    }
  }

  /// Executes an SQL Query that return a single value
  /// params - an optional list of parameters to pass to the query
  /// fromMap - a function that convert the result map to the returned object
  /// singleResult - return an object instead of a list of objects
  Future<dynamic> query(String sql,
      {List<Object?> params = const [],
      FromMap? fromMap,
      bool singleResult = false}) async {
    final List<Map> results = _db.select(sql, params);
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
      {required List<String> keys}) async {
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
    String whereClause = "";
    for (String key in keys) {
      if (whereClause.isNotEmpty) whereClause += ", ";
      whereClause += "$key=?";
      params.add(map[key]);
    }

    final String sql = "UPDATE $table SET $updateClause WHERE $whereClause";
    final res = await execute(sql, tables: [table], params: params);
    return res;
  }

  /// Insert a new record in the passed table based on the map object
  /// and return the new id
  Future<int> insert(Map<String, dynamic> map, String table) async {
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
    final int res = await execute(sql, tables: [table], params: params);
    return res;
  }

  /// DELETE the item building the SQL query using the table and the id passed
  Future<int> delete(Map<String, dynamic> map, String table,
      {required List<String> keys}) async {
    final List params = [];
    // KEYS
    String whereClause = "";
    for (String key in keys) {
      if (whereClause.isNotEmpty) whereClause += ", ";
      whereClause += "$key=?";
      params.add(map[key]);
    }

    final String sql = "DELETE FROM $table WHERE $whereClause";
    final res = await execute(sql, tables: [table], params: params);
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
      required List<String> tables}) {
    final StreamController sc = StreamController();
    // Initial values
    final StreamInfo streamInfo = StreamInfo(
        controller: sc,
        sql: sql,
        tables: tables,
        params: params,
        fromMap: fromMap,
        singleResult: singleResult);
    streams.add(streamInfo);
    _updateStream(streamInfo);
    // Remove from list of streams
    sc.done.then((value) => streams.remove(streamInfo));
    return sc.stream;
  }

  /// Reload data in stream emitting the new result
  _updateStream(StreamInfo streamInfo) async {
    dynamic results = await query(streamInfo.sql,
        params: streamInfo.params,
        singleResult: streamInfo.singleResult,
        fromMap: streamInfo.fromMap);
    streamInfo.controller.add(results);
  }

  /// Update all the streams connected to one of the table in the list
  _updateStreams(List<String>? tables) {
    if (tables == null || tables.isEmpty) return;
    for (StreamInfo s in streams) {
      for (String table in tables) {
        if (s.tables.contains(table)) {
          _updateStream(s);
          continue;
        }
      }
    }
  }

  Future<int> getVersion() async {
    return await query("PRAGMA schema_version;", singleResult: true);
  }

  Future<void> setVersion(int version) async {
    await execute("PRAGMA schema_version=$version;");
  }
}
