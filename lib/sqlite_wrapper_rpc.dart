library sqlite_wrapper;

// ignore: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';

import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:sqlite_wrapper/generated/google/protobuf/any.pb.dart';
import 'package:sqlite_wrapper/generated/google/protobuf/wrappers.pb.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';

class SqliteServiceClientWrapper {
  final SqliteServiceClient client;
  final String dbName;

  SqliteServiceClientWrapper({required this.client, required this.dbName});

  Future<dynamic> select(String sql, List<Object?> params) async {
    final response = await client.select(SqlQueryRequest(
        sql: sql, params: _convertParamsToAny(params), dbName: dbName));
    return jsonDecode(response.result);
  }
}

class SqliteWrapperGrpc extends SQLiteWrapperBase {
  late SqliteServiceClient _client;
  late dynamic _channel;

  SqliteWrapperGrpc({String host = 'localhost', int port = 50051}) {
    // if (isWeb()) port = 8080;
    if (isWeb()) host = "http://localhost";
    // Set the use of GRPC
    useGRPC = true;
    final channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
      host: 'localhost',
      port: 50052,
      transportSecure: false,
    );

    /*_channel = isWeb()
        ? GrpcWebClientChannel.xhr(Uri.parse('http://localhost:50051'))
        :
        ClientChannel(
      host,
      port: port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );*/
    _client = SqliteServiceClient(channel);
  }

  /// Test echo method
  Future<String> echo(String message) async {
    final response = await _client.echo(EchoRequest(message: message));
    return response.message;
  }

  @override
  Future<DatabaseInfo> openDB(String path,
      {int version = 0,
      OnCreate? onCreate,
      OnUpgrade? onUpgrade,
      String? dbName}) async {
    dbName ??= defaultDBName;
    final response = await _client.openDB(OpenDBRequest(
      path: path,
      version: version,
      dbName: dbName,
    ));
    SQLiteWrapperBase.databases.add(
        db: SqliteServiceClientWrapper(client: _client, dbName: dbName),
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
      path: response.path,
    );
  }

  @override
  void closeDB({String? dbName}) async {
    await _client.closeDB(CloseDBRequest(dbName: dbName ?? defaultDBName));
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
      final response = await _client.execute(SqlQueryRequest(
        sql: sql,
        params: _convertParamsToAny(params),
        dbName: dbName ?? defaultDBName,
      ));
      return jsonDecode(response.result);
    } finally {
      await updateStreams(tables);
    }
  }

  @override
  Future<int> getVersion({String? dbName}) async {
    final response = await _client
        .getVersion(GetVersionRequest(dbName: dbName ?? defaultDBName));
    return response.version;
  }

  @override
  Future<void> setVersion(int version, {String? dbName}) async {
    await _client.setVersion(SetVersionRequest(
      dbName: dbName ?? defaultDBName,
      version: version,
    ));
  }

  /// Properly shut down the gRPC channel
  Future<void> shutdown() async {
    await _channel.shutdown();
  }

  /// MAPPING METHODS
}

/// Convert params to Any type
_convertParamsToAny(List params) {
  return params.map((value) {
    if (value is int) {
      return Any.pack(Int64Value()..value = Int64(value));
    } else if (value is String) {
      return Any.pack(StringValue()..value = value);
    } else if (value is bool) {
      return Any.pack(BoolValue()..value = value);
    } else if (value is double) {
      return Any.pack(DoubleValue()..value = value);
    } else if (value == null) {
      return Any();
    }
    throw ArgumentError('Unsupported type: ${value.runtimeType}');
  }).toList();
}
