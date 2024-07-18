library sqlite_wrapper;

// ignore: depend_on_referenced_packages

import 'dart:async';

import 'sqlite_wrapper_base.dart';

class SQLiteWrapperCore extends SQLiteWrapperBase {
  /// Open the Database and returns true if the Database has been created
  @override
  Future<DatabaseInfo> openDB(String path,
      {int version = 0,
      OnCreate? onCreate,
      OnUpgrade? onUpgrade,
      String? dbName}) async {
    dbName ??= defaultDBName;
    bool missingDB = true;
/*    if (path == inMemoryDatabasePath) {
      SQLiteWrapperBase.databases.add(db: sqlite3.openInMemory(), name: dbName);
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
      SQLiteWrapperBase.databases.add(db: sqlite3.open(path), name: dbName);
      if (debugMode) {
        // ignore: avoid_print
        print("DB location: ${SQLiteWrapperBase.databases.get(dbName)}");
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
    }*/
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
