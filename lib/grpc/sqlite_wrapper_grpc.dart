// ignore: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';

import 'package:sqlite_wrapper/grpc/grpc_helper.dart';
import 'package:sqlite_wrapper/grpc/grpc_service_manager.dart';
import 'package:sqlite_wrapper/grpc/sqlite_service_client_wrapper.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';

class SqliteWrapperGRPC extends SQLiteWrapperBase {
  late GrpcServiceManager _serviceManager;
  String _token = "";

  SqliteWrapperGRPC.withHostAndPort(
      {String host = 'localhost', int port = 50051, bool secure = false}) {
    _serviceManager =
        GrpcServiceManager(host: host, port: port, secure: secure);
  }

  void initServiceManager(
      {String host = 'localhost', int port = 50051, bool secure = false}) {
    _serviceManager =
        GrpcServiceManager(host: host, port: port, secure: secure);
  }

  SqliteWrapperGRPC();

  set token(String token) {
    _token = token;
    _serviceManager.token = _token;
  }

  SqliteWrapperServiceClient get client => _serviceManager.sqliteService;

  AuthClient get authClient => _serviceManager.authClient;

  Future<String> echo(String message) async {
    final response = await client.echo(EchoRequest(message: message));
    return response.message;
  }

  @override
  Future<DatabaseInfo> openDB(
    String path, {
    int version = 0,
    OnCreate? onCreate,
    OnUpgrade? onUpgrade,
    String? dbName,
    bool useGRPC = false,
  }) async {
    dbName ??= defaultDBName;
    final response = await client.openDB(
      OpenDBRequest(
        version: version,
        dbName: dbName,
      ),
    );
    databases.add(
        db: SqliteServiceClientWrapper(client: client, dbName: dbName),
        name: dbName,
        useGRPC: useGRPC);
    if (response.created && onCreate != null) {
      await onCreate();
    }
    int currentVersion = await getVersion(dbName: dbName);
    if (onUpgrade != null && version != currentVersion) {
      await onUpgrade(currentVersion, version);
    }
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
  Future<void> closeDB({String? dbName}) async {
    await client.closeDB(CloseDBRequest(dbName: dbName ?? defaultDBName));
    await super.closeDB(dbName: dbName);
  }

  @override
  DatabaseCore? getDatabase({String? dbName}) {
    return databases.get(dbName ?? defaultDBName);
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
