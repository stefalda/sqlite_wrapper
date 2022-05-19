import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';
import 'package:sqlite_wrapper_sample/models.dart';

class DatabaseHelper {
  static final DatabaseHelper _singleton = DatabaseHelper._internal();
  factory DatabaseHelper() {
    return _singleton;
  }

  DatabaseHelper._internal() {}

  initDB({inMemory = false}) async {
    if (inMemory) {
      SQLiteWrapper().openDB(inMemoryDatabasePath);
    } else {
      final docDir = await getApplicationDocumentsDirectory();
      if (!await docDir.exists()) {
        await docDir.create(recursive: true);
      }
      SQLiteWrapper().openDB(p.join(docDir.path, "todoDatabase.sqlite"));
    }
    const String sql = """CREATE TABLE IF NOT EXISTS "todos" (
          "id" integer PRIMARY KEY AUTOINCREMENT NOT NULL,
          "title" varchar(255) NOT NULL,
          "done" int default 0
        );""";
    await SQLiteWrapper().execute(sql);
  }

  /// Return a list of all todos
  Stream getTodos() {
    return SQLiteWrapper()
        .watch("SELECT * FROM todos", tables: ["todos"], fromMap: Todo.fromMap);
  }

  Stream<Map<String, dynamic>> getTodoCount() {
    return Stream.castFrom(SQLiteWrapper().watch("""
        SELECT SUM(done) as done, sum(todo) as todo FROM (
        SELECT COUNT(*) as done,  0 as todo FROM todos where done = 1
        UNION
        SELECT 0 as done,  COUNT(*) as todo FROM todos where done = 0
        ) as todos 
      """, tables: ["todos"], singleResult: true));
  }

  /// Add the new to-do Item
  void addNewTodo(String title) async {
    await SQLiteWrapper().insert(Todo(title: title).toMap(), "todos");
  }

  void toggleDone(Todo todo) async {
    todo.done = !todo.done;
    await SQLiteWrapper().update(todo.toMap(), "todos", keys: ["id"]);
  }

  void deleteTodo(Todo todo) async {
    await SQLiteWrapper().delete(todo.toMap(), "todos", keys: ["id"]);
  }
}
