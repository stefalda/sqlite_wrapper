import 'package:flutter/foundation.dart';
import 'package:inject_x/inject_x.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';
import 'package:sqlite_wrapper_sample/models.dart';

class DatabaseHelper {
  SQLiteWrapperBase get _db => inject<SQLiteWrapperBase>();

  Future<void> initDB({bool inMemory = false}) async {
    String dbPath = inMemoryDatabasePath;
    if (kIsWeb) {
      dbPath = 'todoDatabase';
    } else {
      if (!inMemory) {
        final docDir = await getApplicationDocumentsDirectory();
        if (!await docDir.exists()) {
          await docDir.create(recursive: true);
        }
        dbPath = p.join(docDir.path, "todoDatabase.sqlite");
      }
    }
    final DatabaseInfo dbInfo =
        await _db.openDB(dbPath, onCreate: () async {
      await _db.execute("""CREATE TABLE IF NOT EXISTS "todos" (
            "id" integer PRIMARY KEY AUTOINCREMENT NOT NULL,
            "title" varchar(255) NOT NULL,
            "done" int default 0
          );""");
    });
    debugPrint("Database path: ${dbInfo.path}");
  }

  Stream getTodos() {
    return _db.watch("SELECT * FROM todos", tables: ["todos"], fromMap: Todo.fromMap);
  }

  Stream<Map<String, dynamic>> getTodoCount() {
    return Stream.castFrom(_db.watch("""
        SELECT SUM(done) as done, sum(todo) as todo FROM (
        SELECT COUNT(*) as done,  0 as todo FROM todos where done = 1
        UNION
        SELECT 0 as done,  COUNT(*) as todo FROM todos where done = 0
        ) as todos 
      """, tables: ["todos"], singleResult: true));
  }

  Future<void> addNewTodo(String title) async {
    await _db.insert(Todo(title: title).toMap(), "todos");
  }

  Future<void> toggleDone(Todo todo) async {
    todo.done = !todo.done;
    await _db.update(todo.toMap(), "todos", keys: ["id"]);
  }

  Future<void> deleteTodo(Todo todo) async {
    await _db.delete(todo.toMap(), "todos", keys: ["id"]);
  }

  /// Example of using a transaction for atomic batch operations.
  Future<void> markAllAsDone() async {
    await _db.transaction(() async {
      await _db.execute("UPDATE todos SET done = 1 WHERE done = 0");
    });
  }
}
