import 'package:flutter/material.dart';
import 'package:inject_x/inject_x.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';
import 'package:sqlite_wrapper_sample/database_helper.dart';
import 'package:sqlite_wrapper_sample/todo_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Register the sqlite_wrapper platform instance in the DI container.
  getInstance();

  // Register the DatabaseHelper so it can be injected where needed.
  InjectX.add<DatabaseHelper>(DatabaseHelper());

  // Initialize the database.
  await inject<DatabaseHelper>().initDB();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLiteWrapper Sample',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(title: 'Todos'),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({super.key, required this.title});

  void _addNewTodo() {
    inject<DatabaseHelper>().addNewTodo("NEW TODO");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const TodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTodo,
        tooltip: 'Add new todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
