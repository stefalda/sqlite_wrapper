**sqlite_wrapper** is a simple wrapper around the SQLite3 bindings provided by the [sqlite3](https://pub.dev/packages/sqlite3) package by [Simon Binder](https://pub.dev/publishers/simonbinder.eu/packages).

This library doesn't aim to reach the same features richness of libraries like [drift](https://pub.dev/packages/drift) or [moor](https://pub.dev/packages/moor), but to make it easy to work with [SQLite](https://www.sqlite.org) abstracting just the minimum to enjoy using this great DB from dart and Flutter.

This are the main principles that guide the development of this library:

* no boilerplate
* no generated code
* a reactive API
* a simpler API to converting from and to model objects
* full access to SQL language features without the need to learn new paradings
* fully tested code
* multi-platform (currently tested on iOS, Android, MacOS, Windows) - `Web is not supported`
* no (extreme) magic, but a nice and simple API


## Features

This package provide just a few methods that allow to:

* connect to a SQLite db
* execute sql statements on it
* work with the DB using encoded and decoded maps or model objects
* watch (via streams) for a particular query, getting results reactively and instantly updated
* connect to multiple databases by providing a dbName
* execute a callback when the database is created or when should be migrated to a new schema version

## Getting started

* Install the **sqlite_wrapper** package
* Install the [sqlite3\_flutter_libs](https://pub.dev/packages/sqlite3_flutter_libs) to include the latest version of SQLite on iOS and MacOS (optional) or to make the sqllite3 package work in Android, Windows and Linux (required).

## Usage

A full working Flutter **Todos** example (what else!) is provided in the `/example` folder but here's some information about the available methods (check even the `/test` folder for additional examples).

***sqlite_wrapper*** must be invoked as a singleton (the class returns always the same instance) so there's no need to create or store it in a variable, `SQLiteWrapper()` always returns the same instance.

Most of the methods accept a sql string, an optional list of parameters and an optional list of tables.

**Parameters** can be included in the SQL query as ? (`SELECT * from users where id = ?`).	

The **list of tables** is used by the *reactive* part of the library to know what tables are included in a query (via the `watch` command) and what tables are affected by a particular sql operation (via the `execute` method that is called by all the other *simplified* methods: `insert`, `update`, `delete`.

The optional **dbName** parameter, available in all the methods, allows to manage different databases at the same time, if the database is just one just ignore it, otherwise pass it to declare on which database you want to operate.

### execute

This is the base method called externally and internally when working with the DB.

It returns different results depending of the performed action:
- insert - returns the last inserted row id
- update - returns the number of affected rows
- delete - returns the number of affected rows
- execute - returns the result of the stored procedure (not yet tested)
- other  - returns nothing 

```dart
Future<dynamic>? execute(
 	String sql,
    {List<String>? tables, 
    List<Object?> params = const [],
    String dbName=defaultDBName})
```

### query

This is the method called to get some results from the DB.

It returns a List or a single object (if singleResult=true). The default result object is a ResultSet accessed like a Map but it can return a specific object type when the fromMap method is passed.
If the sql query contains just a return field the result is just that field (i.e. a `SELECT count(*) ` returns an int).

Parameters:
- fromMap - it's a function used to convert the ResultSet returned by the db to a specific model objects implementing a fromMap method
- singleResult - means that the query should return just a single result instead of an array of result (default=false)


```dart
 Future<dynamic> query(
 	String sql,
    {List<Object?> params = const [],
    FromMap? fromMap,
    bool singleResult = false,
    String dbName=defaultDBName})
```

### watch
This method returns a Stream and internally calls the query method.
It accepts a list of tables that are watched for change (operated by the `execute` method).

Parameters:

- tables - the list of table that should be watched for changes (yes, it could be automated by analysing the sql string but, as I said earlier, no magic, because what if it's a join and you just need to watch the first tables?)

```dart
  Stream watch(
  	String sql,
    {List<Object?> params = const [],
    FromMap? fromMap,
    bool singleResult = false,
    required List<String> tables,
    String dbName=defaultDBName})
```


### insert

This is syntactic sugar for the execute method, just pass a map object and the table name and it will perform a single insert to the DB:

```dart
  Future<int> insert(
  	Map<String, dynamic> map, 
  	String table, {String dbName=defaultDBName})
```

### update

Works just like the `insert` but requires a list of key fields (usually just the id - `keys: const['id']`) to perform the update to a single row.

```dart
Future<int> update(
	Map<String, dynamic> map, 
	String table,
    {required List<String> keys, String dbName=defaultDBName})
```

### delete
Works just like the `insert` but requires a list of key fields (usually just the id - `keys: const['id']`) to perform the delete of a single row.

This is the method called to get some results from the DB.
```dart
Future<int> delete(
	Map<String, dynamic> map, 
	String table,
    {required List<String> keys, String dbName=defaultDBName}) 
```

### openDB
Last but not least the first method that should be called to access the database.

Parameters:
- path - full path and name of the database
- version - the custom version of the database schema (default to 0)
- onCreate - a callback that can be used to execute code when the database if firstly created
- onUpdate - a callback that can be used to perform migration (it provides a fromVersion and a toVersion parameter useful to decide which statements must be executed)

if the path is equal to the constant `const String inMemoryDatabasePath = ':memory:';` the database is created in memory (useful for writing tests).

The method returns some information about the database, like if it's just been created and the SQLite library version used.

```dart
  Future<DatabaseInfo> openDB(String path,       
  	{
  		int version = 0,
      OnCreate? onCreate,
   	  OnUpgrade? onUpgrade,
      dbName = defaultDBName}) {
```

### closeDB
Well, you know, it just closes the database

```dart 
 void closeDB()
```

### db
**Handle with care**:
The library exposes the internal database variable just in case you need to do something else with it... 

```dart
 getDatabase({String dbName=defaultDBName}}
 ```


## Examples
Check the `/example` and the `/test` folders for additional examples.

### Open the DB from the document folder
This is the only unavailable boilerplate code, because I didn't want to include any external library except the sqlite3 one.

You should include path and path_provider to get the Document folder and the system path separator.

```dart
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

initDB() async {
    final docDir = await getApplicationDocumentsDirectory();
    if (!await docDir.exists()) {
      await docDir.create(recursive: true);
    }
    await SQLiteWrapper().openDB(p.join(docDir.path, "todoDatabase.sqlite"));
  }
```

### Create a new table

```dart
const String sql = """
		CREATE TABLE IF NOT EXISTS "todos" (
          "id" integer PRIMARY KEY AUTOINCREMENT NOT NULL,
          "title" varchar(255) NOT NULL,
          "done" int default 0
        );""";
        
await SQLiteWrapper().execute(sql);
```

### A simple query - single result

```dart
final Map? userMap = await sqlWrapper.query(
          "SELECT * FROM users WHERE name = 'Paperino'",
          singleResult: true);
```

Mapped to a specific object:

```dart
final User user = await sqlWrapper.query("SELECT * FROM users WHERE name = ?",
    params: ["Paperino"],
    fromMap: User.fromMap,
    singleResult: true);
```

### A simple query - multiple results

```dart
 List<Map> users = await sqlWrapper.query("SELECT * FROM users");

```
Mapped to a list of specific objects:

```dart
List<User> allUsers = List<User>.from(
		await sqlWrapper.query(
          "SELECT * from users order by name DESC",
          fromMap: User.fromMap)
          );
```

### Watch

Watch a single value

```dart
Stream stream = SQLiteWrapper().watch("SELECT COUNT(*) FROM users",
          singleResult: true, 
          tables: ["users"]);
```

Watch a list of mapped objects:

```dart
Stream userStream = SQLiteWrapper().watch("SELECT * FROM users",
          fromMap: User.fromMap, 
          tables: ["users"]);
```


### Insert/Update/Delete

```dart
// insert
User user = User();
user.name = "Paperone";
user.id = await sqlWrapper.insert(user.toMap(), "users");

// update
user.name = "Pippo";
await sqlWrapper.update(user.toMap(), "users", keys: ["id"]);

// delete
res = await sqlWrapper.delete(user.toMap(), "users", keys: ["id"]);
```


## Additional information

I've written this library firstly for my projects, but I think that it can be useful to others too.

If you have questions or want to contribute (in the spirit of this library) please contact me!
Thanks