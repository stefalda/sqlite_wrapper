import 'package:flutter/material.dart';
import 'package:inject_x/inject_x.dart';
import 'package:sqlite_wrapper_sample/registration_page.dart';
import 'package:sqlite_wrapper_sample/services/database_service.dart';
import 'package:sqlite_wrapper_sample/services/registration_info_service.dart';
import 'package:sqlite_wrapper_sample/todo_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseService = InjectX.add(DatabaseService());
  final registrationInfoService = InjectX.add(RegistrationInfoService());
  // Check if a username/password/token are set
  //SQLiteWrapper().client = manager.client;
  // Init the DB
  databaseService.useGRPC = true;
  databaseService.initServiceManager(host: 'localhost', port: 50052);
  await registrationInfoService.getRegistrationInfo();

  await databaseService.echo();
  if (registrationInfoService.registrationInfo.isRegistered) {
    await databaseService.initDB();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final registrationInfo = inject<RegistrationInfoService>().registrationInfo;

    return MaterialApp(
      title: 'SQLiteWrapper Sample',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: registrationInfo.isRegistered
          ? const HomePage(title: 'Todos')
          : RegistrationPage(
              loginVersion: registrationInfo.isRegistered,
              onLogin: () async {
                await inject<DatabaseService>().initDB();
                setState(() {});
              },
            ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({super.key, required this.title});
  void _addNewTodo() {
    inject<DatabaseService>().addNewTodo("NEW TODO");
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: const TodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewTodo,
        tooltip: 'Add new todo',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
