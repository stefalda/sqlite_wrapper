// Factory method
import 'package:inject_x/inject_x.dart';
import 'package:sqlite_wrapper/sqlite_wrapper_base.dart';
// ignore: unused_import
import 'package:sqlite_wrapper/sqlite_wrapper_stub.dart'
    if (dart.library.io) 'package:sqlite_wrapper/sqlite_wrapper_mobile.dart'
    if (dart.library.html) 'package:sqlite_wrapper/sqlite_wrapper_web.dart';

/// Factory to get the current platform instance of [SQLiteWrapperBase].
///
/// Registers the platform instance in InjectX on first call.
/// Subsequent calls return the same registered instance.
/// Use this instead of the deprecated [SQLiteWrapper] singleton.
SQLiteWrapperBase getInstance() {
  if (!InjectX.contains<SQLiteWrapperBase>()) {
    InjectX.add<SQLiteWrapperBase>(SQLiteWrapperCore());
  }
  return InjectX.get<SQLiteWrapperBase>();
}
