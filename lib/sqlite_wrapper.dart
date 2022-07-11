library sqlite_wrapper;

import 'package:sqlite_wrapper/sqlite_wrapper_core.dart';

export 'sqlite_wrapper_core.dart';

class SQLiteWrapper extends SQLiteWrapperCore {
  static final SQLiteWrapper _singleton = SQLiteWrapper._internal();

  factory SQLiteWrapper() {
    return _singleton;
  }

  SQLiteWrapper._internal();
}
