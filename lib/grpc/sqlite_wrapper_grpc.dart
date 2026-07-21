// ignore: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:sqlite_wrapper/grpc/grpc_helper.dart';
import 'package:sqlite_wrapper/grpc/grpc_service_manager.dart';
import 'package:sqlite_wrapper/grpc/sqlite_service_client_wrapper.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';

/// gRPC implementation of [SQLiteWrapperBase].
///
/// Connects to a remote sqlite_wrapper_server via gRPC.
/// Must be created with [SqliteWrapperGRPC.withHostAndPort].
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

  set token(String token) {
    _token = token;
    _serviceManager.token = _token;
  }

  SqliteWrapperServiceClient? clientOverride;

  SqliteWrapperServiceClient get client =>
      clientOverride ?? _serviceManager.sqliteService;

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
    await _serviceManager.dispose();
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
        params: convertParamsToParam(params),
        dbName: dbName ?? defaultDBName,
        tables: tables ?? [],
      ));
      return dartFromValue(response.result);
    } finally {
      if (streams.isNotEmpty) {
        await updateStreams(tables);
      }
    }
  }

  @override
  Stream watch(
    String sql, {
    List<Object?> params = const [],
    FromMap? fromMap,
    bool singleResult = false,
    required List<String> tables,
    String? dbName,
  }) {
    StreamSubscription? sub;
    final sc = StreamController(
      onCancel: () => sub?.cancel(),
    );

    void startWatch() {
      if (sc.isClosed) return;
      sub?.cancel();

      try {
        final responseStream = client.watch(WatchRequest(
          sql: sql,
          params: convertParamsToParam(params),
          dbName: dbName ?? defaultDBName,
          tables: tables,
          singleResult: singleResult,
        ));

        sub = responseStream.listen(
          (response) {
            if (singleResult) {
              if (response.rows.isNotEmpty) {
                // Single row with multiple columns → Map result
                final map = mapsFromRows(response.rows.toList()).first;
                if (fromMap != null) {
                  sc.add(fromMap(map));
                } else {
                  sc.add(map);
                }
              } else {
                // Scalar result
                final val = dartFromValue(response.result);
                if (fromMap != null && val is Map<String, dynamic>) {
                  sc.add(fromMap(val));
                } else {
                  sc.add(val);
                }
              }
            } else {
              final rows = mapsFromRows(response.rows.toList());
              if (fromMap != null) {
                sc.add(rows.map((e) => fromMap(e)).toList());
              } else {
                sc.add(rows);
              }
            }
          },
          onDone: () {
            if (!sc.isClosed) {
              Future.delayed(const Duration(seconds: 1), startWatch);
            }
          },
          onError: (e) {
            if (!sc.isClosed) {
              Future.delayed(const Duration(seconds: 2), startWatch);
            }
          },
          cancelOnError: false,
        );
      } catch (e) {
        if (!sc.isClosed) {
          Future.delayed(const Duration(seconds: 2), startWatch);
        }
      }
    }

    startWatch();
    return sc.stream;
  }

  @override
  Future<List<dynamic>> executeBatch(
    List<String> sqls, {
    List<List<Object?>>? paramsList,
    List<String>? dbName,
    List<List<String>>? tablesList,
  }) async {
    final requests = <SqlQueryRequest>[];
    final count = sqls.length;
    for (int i = 0; i < count; i++) {
      requests.add(SqlQueryRequest(
        sql: sqls[i],
        params: convertParamsToParam(paramsList?[i] ?? []),
        dbName: dbName?[i] ?? defaultDBName,
        tables: tablesList?[i] ?? [],
      ));
    }
    final response = await client.executeBatch(BatchRequest(requests: requests));
    return response.responses
        .map((r) => dartFromValue(r.result))
        .toList();
  }

  /// Export the entire database as raw bytes (backup).
  Future<List<int>> exportBackup({String? dbName}) async {
    final response = await client.exportBackup(ExportBackupRequest(
      dbName: dbName ?? defaultDBName,
    ));
    return response.data;
  }

  /// Import a database from raw bytes (restore).
  /// Returns [ImportBackupResponse] with success status and message.
  Future<ImportBackupResponse> importBackup(Uint8List data,
      {String? dbName}) async {
    return await client.importBackup(ImportBackupRequest(
      dbName: dbName ?? defaultDBName,
      data: data,
    ));
  }

  /// Execute a SQL query and return the result as a CSV string.
  Future<String> exportCSV(String sql, {String? dbName}) async {
    final response = await client.exportCSV(ExportCSVRequest(
      dbName: dbName ?? defaultDBName,
      sql: sql,
    ));
    return utf8.decode(response.data);
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
