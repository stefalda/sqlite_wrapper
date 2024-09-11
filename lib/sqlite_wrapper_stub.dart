import 'package:sqlite_wrapper/sqlite_wrapper_types.dart';

import 'sqlite_wrapper_base.dart';

SQLiteWrapperBase getInstance() =>
    throw UnsupportedError("Unsupported platform");

/// Unused stub implementation just to keep the compiler happy
class SQLiteWrapperCore extends SQLiteWrapperBase {
  @override
  Future<DatabaseInfo> openDB(String path,
      {int version = 0,
      OnCreate? onCreate,
      OnUpgrade? onUpgrade,
      String? dbName}) {
    throw UnimplementedError();
  }
}
