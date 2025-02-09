import 'package:sqlite_wrapper/sqlite_wrapper.dart';

abstract class SqliteWrapperInterface {
  /// Open the Database and returns true if the Database has been created
  Future<DatabaseInfo> openDB(String path,
      {int version = 0,
      OnCreate? onCreate,
      OnUpgrade? onUpgrade,
      String? dbName});

  /// Close the Database
  void closeDB({String? dbName});

  /// Database accessible from outside (map the internal db instance)
  dynamic getDatabase({String? dbName});

  /// Executes an SQL Query with no return value
  /// params - an optional list of parameters to pass to the query
  /// tables - an optional list of tables affected by the query
  Future<dynamic>? execute(String sql,
      {List<String>? tables, List<Object?> params = const [], String? dbName});

  /*
  /// Executes an SQL Query that return a single value
  /// params - an optional list of parameters to pass to the query
  /// fromMap - a function that convert the result map to the returned object
  /// singleResult - return an object instead of a list of objects
  Future<dynamic> query(String sql,
      {List<Object?> params = const [],
      FromMap? fromMap,
      bool singleResult = false,
      String? dbName});

  Future<int> update(Map<String, dynamic> map, String table,
      {required List<String> keys, String? dbName});

  /// Insert a new record in the passed table based on the map object
  /// and return the new id
  Future<int> insert(Map<String, dynamic> map, String table, {String? dbName});

  // Perform an INSERT or an UPDATE depending on the record state (UPSERT)
  Future<int> save(Map<String, dynamic> map, String table,
      {List<String>? keys, String? dbName});

  /// DELETE the item building the SQL query using the table and the id passed
  Future<int> delete(Map<String, dynamic> map, String table,
      {required List<String> keys, String? dbName});

  /// Executes an SQL Query that return a single value
  /// params - an optional list of parameters to pass to the query
  /// fromMap - a function that convert the result map to the returned object
  /// singleResult - return an object instead of a list of objects
  Stream watch(String sql,
      {List<Object?> params = const [],
      FromMap? fromMap,
      bool singleResult = false,
      required List<String> tables,
      String? dbName});
  
  /// Update all the streams connected to one of the table in the list
  Future<void> updateStreams(List<String>? tables);
  */
  Future<int> getVersion({String? dbName});

  Future<void> setVersion(int version, {String? dbName});
}
