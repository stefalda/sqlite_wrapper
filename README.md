[![CI](https://github.com/stefalda/sqlite_wrapper/actions/workflows/dart.yml/badge.svg)](https://github.com/stefalda/sqlite_wrapper/actions/workflows/dart.yml)

**sqlite_wrapper** is a simple wrapper around the SQLite3 bindings provided by
the [sqlite3](https://pub.dev/packages/sqlite3) package by
[Simon Binder](https://pub.dev/publishers/simonbinder.eu/packages).

This library doesn't aim to reach the same features richness of libraries like
[drift](https://pub.dev/packages/drift) or
[moor](https://pub.dev/packages/moor), but to make it easy to work with
[SQLite](https://www.sqlite.org) abstracting just the minimum to enjoy using
this great DB from dart and Flutter.

This are the main principles that guide the development of this library:

- no boilerplate
- no generated code
- a reactive API
- a simpler API to converting from and to model objects
- full access to SQL language features without the need to learn new paradings
- fully tested code
- multi-platform (currently tested on iOS, Android, MacOS, Windows, Web)
- no (extreme) magic, but a nice and simple API

## Features

This package provides just a few methods that allow to:

- connect to a SQLite db
- execute sql statements on it
- work with the DB using encoded and decoded maps or model objects
- watch (via streams) for a particular query, getting results reactively and
  instantly updated
- connect to multiple databases by providing a dbName
- execute a callback when the database is created or when should be migrated to
  a new schema version
- execute operations inside a transaction with automatic commit/rollback

## Getting started

- Install the **sqlite_wrapper** package
- Install the
  [sqlite3\_flutter_libs](https://pub.dev/packages/sqlite3_flutter_libs) to
  include the latest version of SQLite on iOS and MacOS (optional) or to make
  the sqllite3 package work in Android, Windows and Linux (required).
- Install and **configure** (generate sqlite.wasm)
  [sqflite_common_ffi_web](https://pub.dev/packages/sqflite_common_ffi_web)
  package if you want to use the library in flutter web. In particular you
  should run this command to generate or update the required files in your web
  folder.

<pre>
  $ dart run sqflite_common_ffi_web:setup --force
</pre>

## Imports

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  sqlite_wrapper: ^0.4.0
  inject_x: ^0.0.6
```

Required imports in your Dart code:

```dart
// Main package — provides SQLiteWrapperBase, SQLiteWrapperCore, getInstance(), types
import 'package:sqlite_wrapper/sqlite_wrapper.dart';

// Dependency injection (required for inject<T>() / InjectX)
import 'package:inject_x/inject_x.dart';
```

**Flutter web only** — add and configure `sqflite_common_ffi_web`:

```yaml
dependencies:
  sqflite_common_ffi_web: ^1.0.0
```

Then run:

```
dart run sqflite_common_ffi_web:setup --force
```

**Windows/Linux only** (deprecated `sqlite3_flutter_libs` alternative) — add manually if the platform does not bundle SQLite:

```yaml
dependencies:
  sqlite3_flutter_libs: ^0.5.0
```

The `sqlite_wrapper` package already includes `sqlite3` — you do not need to add it yourself.

## Dependency Injection

sqlite_wrapper uses [inject_x](https://pub.dev/packages/inject_x) for dependency injection.
The old `SQLiteWrapper` singleton is deprecated.

### Register the platform instance

In your app's `main()`, call `getInstance()` to register the platform-specific
implementation:

```dart
import 'package:sqlite_wrapper/sqlite_wrapper.dart';

void main() {
  getInstance(); // registers SQLiteWrapperCore in the DI container
  ...
}
```

Alternatively, register manually with `inject_x`:

```dart
import 'package:inject_x/inject_x.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';

void main() {
  InjectX.add<SQLiteWrapperBase>(SQLiteWrapperCore());
  ...
}
```

### Use it anywhere

```dart
import 'package:inject_x/inject_x.dart';

final db = inject<SQLiteWrapperBase>();
```

### Testing

In tests you can instantiate `SQLiteWrapperCore` directly (no inject_x needed):

```dart
import 'package:sqlite_wrapper/sqlite_wrapper.dart';

final db = SQLiteWrapperCore();
await db.openDB(inMemoryDatabasePath);
```

## gRPC

The Web version defaults to the WASM implementation of SQLite, which can be slow
with large databases or when syncing data with the
[sync_client](https://github.com/stefalda/sync_client) package.

That's why the library includes a [gRPC](https://grpc.io/) implementation that
lets you use a remote SQLite database as if it were local. All calls are
forwarded to a
[sqlite_wrapper_server](https://github.com/stefalda/sqlite_wrapper_server)
instance via gRPC.

### Setup

Create a `SqliteWrapperGRPC` instance instead of `SQLiteWrapperCore`:

```dart
import 'package:sqlite_wrapper/sqlite_wrapper.dart';

final db = SqliteWrapperGRPC.withHostAndPort(
  host: '192.168.1.100',
  port: 50051,
  secure: false, // use TLS in production
);
```

Register it with `inject_x`:

```dart
import 'package:inject_x/inject_x.dart';

void main() {
  InjectX.add<SQLiteWrapperBase>(
    SqliteWrapperGRPC.withHostAndPort(
      host: '192.168.1.100',
      port: 50051,
    ),
  );
}
```

### Authentication (optional)

If the server requires authentication, register or log in and set the token:

```dart
// Register a new user
final authResponse = await db.authClient.register('user@example.com', 'password');

// Or log in
final authResponse = await db.authClient.login('user@example.com', 'password');

// Set the token — all subsequent gRPC calls include it
db.token = authResponse.token;
```

### Complete example

```dart
import 'package:inject_x/inject_x.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';

void main() async {
  // 1. Create the gRPC client
  final db = SqliteWrapperGRPC.withHostAndPort(
    host: '192.168.1.100',
    port: 50051,
  );

  // 2. Authenticate (if required)
  final response = await db.authClient.login('admin', 'secret');
  db.token = response.token;

  // 3. Open a remote database
  await db.openDB('my_remote_db');

  // 4. Use it like a local database
  await db.execute('''
    CREATE TABLE IF NOT EXISTS items (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL
    )
  ''');

  final id = await db.insert({'name': 'hello'}, 'items');
  final items = await db.query('SELECT * FROM items');
}
```

### watch() with gRPC

`watch()` works via gRPC using the **server-side streaming** RPC (`rpc Watch`).
The server pushes new results to the client whenever the watched tables change.
Changes made by other clients are detected and propagated in real time.

### Export/Backup/CSV (v0.7.0+)

The gRPC implementation exposes three additional methods on `SqliteWrapperGRPC`
for backup, restore, and CSV export — useful for web clients that cannot access
the local filesystem.

```dart
// Export the entire database as raw bytes (download as .sqlite)
final backupBytes = await db.exportBackup();

// Import/restore a database from raw bytes
final response = await db.importBackup(Uint8List.fromList(bytes));
if (response.success) {
  print('Restore succeeded');
}

// Export query results as a CSV string
final csv = await db.exportCSV('SELECT * FROM books');
```

These methods call the corresponding `ExportBackup`, `ImportBackup`, and
`ExportCSV` RPCs on the server. See the server README for details on the
server-side implementation.

### Regenerate protobuf stubs

After changing the `.proto` files, run:

```bash
./protos/refresh.sh
```

### Server

The server implementation is available at
[sqlite_wrapper_server](https://github.com/stefalda/sqlite_wrapper_server) with
a client example.

## Usage

A full working Flutter **Todos** example (what else!) is provided in the
`/example` folder but here's some information about the available methods (check
even the `/test` folder for additional examples).

Most of the methods accept a sql string, an optional list of parameters and an
optional list of tables.

**Parameters** can be included in the SQL query as ?
(`SELECT * from users where id = ?`).

The **list of tables** is used by the _reactive_ part of the library to know
what tables are included in a query (via the `watch` command) and what tables
are affected by a particular sql operation (via the `execute` method that is
called by all the other _simplified_ methods: `insert`, `update`, `delete`.

The optional **dbName** parameter, available in all the methods, allows to
manage different databases at the same time, if the database is just one just
ignore it, otherwise pass it to declare on which database you want to operate.

### execute

This is the base method called externally and internally when working with the
DB.

It returns different results depending of the performed action:

- insert - returns the last inserted row id
- update - returns the number of affected rows
- delete - returns the number of affected rows
- execute - returns the result of the stored procedure (not yet tested)
- other - returns nothing

```dart
Future<dynamic> execute(
    String sql,
    {List<String>? tables, 
    List<Object?> params = const [],
    String dbName=defaultDBName})
```

### query

This is the method called to get some results from the DB.

It returns a List or a single object (if singleResult=true). The default result
object is a ResultSet accessed like a Map but it can return a specific object
type when the fromMap method is passed. If the sql query contains just a return
field the result is just that field (i.e. a `SELECT count(*)` returns an int).

Parameters:

- fromMap - it's a function used to convert the ResultSet returned by the db to
  a specific model objects implementing a fromMap method
- singleResult - means that the query should return just a single result instead
  of an array of result (default=false)

```dart
Future<dynamic> query(
    String sql,
   {List<Object?> params = const [],
   FromMap? fromMap,
   bool singleResult = false,
   String dbName=defaultDBName})
```

### watch

This method returns a Stream and internally calls the query method. It accepts a
list of tables that are watched for change (operated by the `execute` method).

Parameters:

- tables - the list of table that should be watched for changes (yes, it could
  be automated by analysing the sql string but, as I said earlier, no magic,
  because what if it's a join and you just need to watch the first tables?)

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

This is syntactic sugar for the execute method, just pass a map object and the
table name and it will perform a single insert to the DB:

```dart
Future<int> insert(
    Map<String, dynamic> map, 
    String table, {String dbName=defaultDBName})
```

### update

Works just like the `insert` but requires a list of key fields (usually just the
id - `keys: const['id']`) to perform the update to a single row.

```dart
Future<int> update(
    Map<String, dynamic> map, 
    String table,
    {required List<String> keys, String dbName=defaultDBName})
```

### save

Try to perform an INSERT or, if a row with the same key already exists, an
UPDATE (this function is usually defined as an UPSERT). It requires a list of
key fields (usually just the id - `keys: const['id']`) to perform the update to
a single row.

```dart
Future<int> save(
    Map<String, dynamic> map, 
    String table,
    {required List<String> keys, String dbName=defaultDBName})
```

### delete

Works just like the `insert` but requires a list of key fields (usually just the
id - `keys: const['id']`) to perform the delete of a single row.

This is the method called to get some results from the DB.

```dart
Future<int> delete(
    Map<String, dynamic> map, 
    String table,
    {required List<String> keys, String dbName=defaultDBName})
```

### openDB

Last but not least the first method that should be called to access the
database.

Parameters:

- path - full path and name of the database
- version - the custom version of the database schema (default to 0)
- onCreate - a callback that can be used to execute code when the database if
  firstly created
- onUpdate - a callback that can be used to perform migration (it provides a
  fromVersion and a toVersion parameter useful to decide which statements must
  be executed)

if the path is equal to the constant
`const String inMemoryDatabasePath = ':memory:';` the database is created in
memory (useful for writing tests).

The method returns some information about the database, like if it's just been
created and the SQLite library version used.

```dart
Future<DatabaseInfo> openDB(String path,       
    {
        int version = 0,
    OnCreate? onCreate,
      OnUpgrade? onUpgrade,
    dbName = defaultDBName}) {
```

### closeDB

Closes the database and cleans up its associated reactive streams.

```dart
Future<void> closeDB({String dbName=defaultDBName})
```

### executeBatch (gRPC only, v0.6.0+)

Executes multiple SQL statements in a single round-trip (gRPC transport) or
sequentially (native). On gRPC this batches all requests into one `ExecuteBatch`
RPC, significantly reducing latency for composite operations.

Returns a list of results in the same order as the SQL statements.
Each result is the scalar value (last_insert_rowid for INSERT, changes for
UPDATE/DELETE) or null for statements that don't produce one.

```dart
Future<List<dynamic>> executeBatch(
  List<String> sqls, {
  List<List<Object?>>? paramsList,
  List<String>? dbName,
  List<List<String>>? tablesList,
})
```

Example — batch two independent SELECT queries:
```dart
final results = await db.executeBatch([
  "SELECT publisherid FROM publishers WHERE publishername=?",
  "SELECT authorid FROM authors WHERE authorname=?",
], paramsList: [
  ["John Wiley"],
  ["J. R. R. Tolkien"],
]);
final publisherId = results[0] as String?;
final authorId = results[1] as String?;
```

### transaction

Executes operations atomically. On success the transaction is committed and
all reactive streams are refreshed. On error the transaction is rolled back
and streams are not updated.

```dart
Future<T> transaction<T>(Future<T> Function() action, {String? dbName})
```

Example:
```dart
await db.transaction(() async {
  await db.execute("INSERT INTO accounts (name, balance) VALUES (?, ?)", params: ["Alice", 100]);
  await db.execute("INSERT INTO accounts (name, balance) VALUES (?, ?)", params: ["Bob", 200]);
});
```

### db

**Handle with care**: The library exposes the internal database variable just in
case you need to do something else with it...

```dart
DatabaseCore? getDatabase({String dbName=defaultDBName})
```

## Examples

Check the `/example` and the `/test` folders for additional examples.

### Open the DB from the document folder

This is the only unavailable boilerplate code, because I didn't want to include
any external library except the sqlite3 one.

You should include path and path_provider to get the Document folder and the
system path separator.

```dart
import 'package:inject_x/inject_x.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

final db = inject<SQLiteWrapperBase>();

initDB() async {
    final docDir = await getApplicationDocumentsDirectory();
    if (!await docDir.exists()) {
      await docDir.create(recursive: true);
    }
    await db.openDB(p.join(docDir.path, "todoDatabase.sqlite"));
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
        
await db.execute(sql);
```

### A simple query - single result

```dart
final Map? userMap = await db.query(
          "SELECT * FROM users WHERE name = 'Paperino'",
          singleResult: true);
```

Mapped to a specific object:

```dart
final User user = await db.query("SELECT * FROM users WHERE name = ?",
    params: ["Paperino"],
    fromMap: User.fromMap,
    singleResult: true);
```

### A simple query - multiple results

```dart
List<Map> users = await db.query("SELECT * FROM users");
```

Mapped to a list of specific objects:

```dart
List<User> allUsers = List<User>.from(
    await db.query(
          "SELECT * from users order by name DESC",
          fromMap: User.fromMap)
          );
```

### Watch

Watch a single value

```dart
Stream stream = db.watch("SELECT COUNT(*) FROM users",
          singleResult: true, 
          tables: ["users"]);
```

Watch a list of mapped objects:

```dart
Stream userStream = db.watch("SELECT * FROM users",
          fromMap: User.fromMap, 
          tables: ["users"]);
```

### Insert/Update/Delete

```dart
// insert
User user = User();
user.name = "Paperone";
user.id = await db.insert(user.toMap(), "users");

// update
user.name = "Pippo";
await db.update(user.toMap(), "users", keys: ["id"]);

// delete
res = await db.delete(user.toMap(), "users", keys: ["id"]);
```

### Transaction

```dart
await db.transaction(() async {
  await db.execute("UPDATE accounts SET balance = balance - 100 WHERE name = 'Alice'");
  await db.execute("UPDATE accounts SET balance = balance + 100 WHERE name = 'Bob'");
});
```

## Additional information

I've written this library firstly for my projects, but I think that it can be
useful to others too.

If you have questions or want to contribute (in the spirit of this library)
please contact me! Thanks
