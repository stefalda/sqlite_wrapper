// ignore: depend_on_referenced_packages

import 'dart:async';

import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqlite_wrapper/sqlite_wrapper_types.dart';

import 'sqlite_wrapper_base.dart';

SQLiteWrapperBase getInstance() => SQLiteWrapperCore();

/// Sqflite web database adapter implementing [DatabaseCore].
/// Delegates to sqflite_common_ffi_web's async Database API.
class SqfliteWebDatabase implements DatabaseCore {
  final dynamic _db;

  SqfliteWebDatabase(this._db);

  @override
  Future<void> execute(String sql, List<Object?> params) async {
    await _db.execute(sql, params);
  }

  @override
  Future<List<Map<String, dynamic>>> select(
      String sql, List<Object?> params) async {
    final result = await _db.rawQuery(sql, params);
    return result.cast<Map<String, dynamic>>();
  }

  @override
  void dispose() => _db.close();
}

class SQLiteWrapperCore extends SQLiteWrapperBase {
  /// Open the Database and returns [DatabaseInfo] with creation status and version.
  @override
  Future<DatabaseInfo> openDB(
    String path, {
    int version = 0,
    OnCreate? onCreate,
    OnUpgrade? onUpgrade,
    String? dbName,
    bool useGRPC = false,
  }) async {
    dbName ??= defaultDBName;
    bool missingDB = true;
    final factory = databaseFactoryFfiWeb;
    final db = await factory.openDatabase(path);
    databases.add(db: SqfliteWebDatabase(db), name: dbName);
    if (missingDB && onCreate != null) {
      await onCreate();
    }
    int currentVersion = await getVersion(dbName: dbName);
    if (onUpgrade != null && version != currentVersion) {
      await onUpgrade(currentVersion, version);
    }
    if (version != currentVersion) {
      await setVersion(version, dbName: dbName);
    }
    return DatabaseInfo(
        path: path,
        created: missingDB,
        version: version,
        dbName: dbName,
        sqliteVersion: "unknown");
  }

  @override
  Future<int> getVersion({String? dbName}) async {
    return await query("PRAGMA user_version;",
        singleResult: true, dbName: dbName);
  }

  @override
  Future<void> setVersion(int version, {String? dbName}) async {
    await execute("PRAGMA user_version=$version;", dbName: dbName);
  }
}
