library sqlite_wrapper;

// ignore: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';

import 'package:sqlite_wrapper/grpc/grpc_helper.dart';
import 'package:sqlite_wrapper/grpc/grpc_service_manager.dart';
import 'package:sqlite_wrapper/grpc/sqlite_service_client_wrapper.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';

class SqliteWrapperGRPC extends SQLiteWrapperBase {
  // Client should be passed from the Manager just after instantiating the
  late GrpcServiceManager _serviceManager;
  String _token = "";

  // Init the class passing the client
  SqliteWrapperGRPC.withHostAndPort(
      {String host = 'localhost', int port = 50051, bool secure = false}) {
    _serviceManager =
        GrpcServiceManager(host: host, port: port, secure: secure);
  }

  /// Init the manager
  initServiceManager(
      {String host = 'localhost', int port = 50051, bool secure = false}) {
    _serviceManager =
        GrpcServiceManager(host: host, port: port, secure: secure);
  }

  SqliteWrapperGRPC() {
    // Set the use of GRPC
    useGRPC = true;
  }

  /// Set the grpc token
  set token(String token) {
    _token = token;
    //_token =
    //    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InN0ZWZhbm8uZmFsZGFAZ21haWwuY29tIiwiaWF0IjoxNzM5MzE2MzMyfQ.6WpGX1JcMjc0cXVOAk87X2cPUwbddVbdD9h0BM-ON7A";
    _serviceManager.token = _token;
  }

  SqliteWrapperServiceClient get client => _serviceManager.sqliteService;

  AuthClient get authClient => _serviceManager.authClient;

  /// Test echo method
  Future<String> echo(String message) async {
    final response = await client.echo(EchoRequest(message: message));
    return response.message;
  }

  @override
  Future<DatabaseInfo> openDB(String path,
      {int version = 0,
      OnCreate? onCreate,
      OnUpgrade? onUpgrade,
      String? dbName}) async {
    dbName ??= defaultDBName;
    final response = await client.openDB(
      OpenDBRequest(
        version: version,
        dbName: dbName,
      ),
    );
    SQLiteWrapperBase.databases.add(
        db: SqliteServiceClientWrapper(client: client, dbName: dbName),
        name: dbName);
    // Execute the onCreate method if is set
    if (response.created && onCreate != null) {
      await onCreate();
    }
    // Execute the onUpdate method if the version is set
    int currentVersion = await getVersion(dbName: dbName);
    if (onUpgrade != null && version != currentVersion) {
      await onUpgrade(currentVersion, version);
    }
    // Set the version
    if (version != currentVersion) {
      await setVersion(version, dbName: dbName);
    }
    return DatabaseInfo(
      created: response.created,
      version: response.version,
      sqliteVersion: response.sqliteVersion,
      dbName: response.dbName,
      path: response.dbName,
    );
  }

  @override
  void closeDB({String? dbName}) async {
    await client.closeDB(CloseDBRequest(dbName: dbName ?? defaultDBName));
  }

  @override
  dynamic getDatabase({String? dbName}) {
    throw UnimplementedError('This operation is not supported via gRPC');
  }

  @override
  Future<dynamic> execute(String sql,
      {List<String>? tables,
      List<Object?> params = const [],
      String? dbName}) async {
    try {
      final response = await client.execute(SqlQueryRequest(
        sql: sql,
        params: convertParamsToAny(params),
        dbName: dbName ?? defaultDBName,
      ));
      return jsonDecode(response.result);
    } finally {
      await updateStreams(tables);
    }
  }

  @override
  Future<int> getVersion({String? dbName}) async {
    final response = await client
        .getVersion(GetVersionRequest(dbName: dbName ?? defaultDBName));
    return response.version;
  }

  @override
  Future<void> setVersion(int version, {String? dbName}) async {
    await client.setVersion(SetVersionRequest(
      dbName: dbName ?? defaultDBName,
      version: version,
    ));
  }
}
