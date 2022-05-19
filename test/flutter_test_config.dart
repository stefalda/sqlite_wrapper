import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';

const String inMemoryDatabasePath = ':memory:';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  setUp(() async {
    SQLiteWrapper().openDB(inMemoryDatabasePath);
    //SQLiteWrapper().openDB("dbProva.sqlite");
  });

  tearDown(() async {
    SQLiteWrapper().closeDB();
  });

  await testMain();
}
