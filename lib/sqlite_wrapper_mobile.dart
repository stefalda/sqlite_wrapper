// ignore: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite_wrapper/sqlite_wrapper_types.dart';

import 'sqlite_wrapper_base.dart';

SQLiteWrapperBase getInstance() => SQLiteWrapperCore();

/// Sqlite3 database adapter implementing [DatabaseCore].
/// Wraps synchronous sqlite3 calls in async for uniform access.
class Sqlite3Database implements DatabaseCore {
  final Database _db;

  Sqlite3Database(this._db);

  @override
  Future<void> execute(String sql, List<Object?> params) async {
    _db.execute(sql, params);
  }

  @override
  Future<List<Map<String, dynamic>>> select(
      String sql, List<Object?> params) async {
    return _db.select(sql, params).map((r) => r as Map<String, dynamic>).toList();
  }

  @override
  void dispose() => _db.close();
}

class SQLiteWrapperCore extends SQLiteWrapperBase {
  /// Open the Database and returns [DatabaseInfo] with creation status, version and sqlite version.
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
    if (path == inMemoryDatabasePath) {
      databases.add(db: Sqlite3Database(sqlite3.openInMemory()), name: dbName);
    } else {
      final File f = File(path);
      missingDB = !f.existsSync();
      if (missingDB) {
        var dir = Directory.fromUri(Uri.directory(path));
        if (!dir.parent.existsSync()) {
          dir.parent.createSync(recursive: true);
        }
      }
      databases.add(db: Sqlite3Database(sqlite3.open(path)), name: dbName);
      if (debugMode) {
        // ignore: avoid_print
        print("DB location: ${databases.get(dbName)}");
      }
    }
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
        sqliteVersion: sqlite3.version.toString());
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
