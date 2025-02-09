import 'package:sqlite_wrapper/sqlite_wrapper_rpc.dart';

class SQLiteWrapper extends SqliteWrapperGrpc {
  static final SQLiteWrapper _singleton = SQLiteWrapper._internal();

  factory SQLiteWrapper() {
    return _singleton;
  }

  SQLiteWrapper._internal();
}
