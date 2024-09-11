// Factory method
import 'package:sqlite_wrapper/sqlite_wrapper_base.dart';
// ignore: unused_import
import 'package:sqlite_wrapper/sqlite_wrapper_stub.dart'
    if (dart.library.io) 'package:sqlite_wrapper/sqlite_wrapper_mobile.dart'
    if (dart.library.html) 'package:sqlite_wrapper/sqlite_wrapper_web.dart';

/// Factory to get the current platform instance of SQLiteWrapper
/// you can use this instead of the singleton SQLiteWrapper
SQLiteWrapperBase getInstance() => getInstance();
