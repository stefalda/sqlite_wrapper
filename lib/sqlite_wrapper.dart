library sqlite_wrapper;

import 'sqlite_wrapper_stub.dart'
    if (dart.library.io) 'sqlite_wrapper_mobile.dart'
    if (dart.library.js_interop) 'sqlite_wrapper_web.dart';

export './helpers/platform/platform.dart';
export 'generated/sqlite_wrapper_rpc.pb.dart';
export 'generated/sqlite_wrapper_rpc.pbenum.dart';
export 'generated/sqlite_wrapper_rpc.pbgrpc.dart';
export 'generated/sqlite_wrapper_rpc.pbjson.dart';
export 'grpc/sqlite_wrapper_rpc.dart';
export 'interfaces/sqlite_wrapper_interface.dart';
export 'sqlite_wrapper_base.dart';
export 'sqlite_wrapper_factory.dart';
export 'sqlite_wrapper_stub.dart'
    if (dart.library.io) 'sqlite_wrapper_mobile.dart'
    if (dart.library.js_interop) 'sqlite_wrapper_web.dart' hide getInstance;
export 'sqlite_wrapper_types.dart';
export 'grpc/auth_client.dart';
class SQLiteWrapper extends SQLiteWrapperCore {
  static final SQLiteWrapper _singleton = SQLiteWrapper._internal();

  factory SQLiteWrapper() {
    return _singleton;
  }

  SQLiteWrapper._internal();
}
