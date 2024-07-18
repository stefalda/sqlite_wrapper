library sqlite_wrapper;

import 'sqlite_wrapper_stub.dart'
    if (dart.library.io) 'sqlite_wrapper_core.dart'
    if (dart.library.js_interop) 'sqlite_wrapper_web.dart';

export 'sqlite_wrapper_base.dart';
export 'sqlite_wrapper_stub.dart'
    if (dart.library.io) 'sqlite_wrapper_core.dart'
    if (dart.library.js_interop) 'sqlite_wrapper_web.dart';

class SQLiteWrapper extends SQLiteWrapperCore {
  static final SQLiteWrapper _singleton = SQLiteWrapper._internal();

  factory SQLiteWrapper() {
    return _singleton;
  }

  SQLiteWrapper._internal();
}
