import 'dart:convert';

import 'package:grpc/grpc.dart';
import 'package:sqlite_wrapper/generated/google/protobuf/any.pb.dart';
import 'package:sqlite_wrapper/generated/google/protobuf/wrappers.pb.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';

//import 'generated/sqlite_wrapper_rpc.pbgrpc.dart';
/*
/// A token-based interceptor that validates the "authorization" metadata header.
class AuthInterceptor extends ServerInterceptor {
  @override
  Future<GrpcError?> intercept(
    ServiceCall call,
    ServiceMethod method,
    Future<void> Function(ServiceCall call) continuation,
  ) async {
    // Retrieve metadata from the incoming call.
    final metadata = call.clientMetadata;
    if (metadata == null || !metadata.containsKey('authorization')) {
      return GrpcError.unauthenticated('Missing authorization metadata');
    }

    // Metadata values are lists; here we take the first value.
    final token = metadata['authorization']!.first;
    if (!isValidToken(token)) {
      return GrpcError.permissionDenied('Invalid token');
    }

    // Token is valid; continue processing the RPC.
    return await continuation(call);
  }

  bool isValidToken(String token) {
    // Replace this logic with your actual token validation.
    return token == 'Bearer valid_token';
  }
}*/

/// Implementation of the SqliteService defined in your sqlite.proto.
class SqliteServiceImpl extends SqliteServiceBase {
  static final List<StreamInfo> streams = [];
  final sqliteWrapper = SQLiteWrapperCore();

  @override
  Future<OpenDBResponse> openDB(ServiceCall call, OpenDBRequest request) async {
    print(
        "OpenDB called: path=${request.path}, version=${request.version}, dbName=${request.dbName}");

    final res = await sqliteWrapper.openDB(request.path,
        dbName: request.dbName, version: request.version);
    // Dummy response; replace with actual database opening logic.
    return OpenDBResponse(
      created: res.created,
      version: res.version,
      sqliteVersion: res.sqliteVersion,
      dbName: res.dbName,
      path: res.path,
    );
  }

  @override
  Future<CloseDBResponse> closeDB(
      ServiceCall call, CloseDBRequest request) async {
    sqliteWrapper.closeDB(dbName: request.dbName);
    print("CloseDB called: dbName=${request.dbName}");
    return CloseDBResponse(success: true);
  }

  @override
  Future<SqlQueryResponse> execute(
      ServiceCall call, SqlQueryRequest request) async {
    print(
        "Execute called: sql=${request.sql}, params=${request.params}, dbName=${request.dbName}");
    final res = await sqliteWrapper.execute(
      request.sql,
      params: _unpack(request.params.toList()),
      dbName: request.dbName,
    );

    // Replace with actual SQL command execution.
    return SqlQueryResponse(result: jsonEncode(res));
  }

  @override
  Future<SqlQueryResponse> select(
      ServiceCall call, SqlQueryRequest request) async {
    print(
        "Select called: sql=${request.sql}, params=${request.params}, dbName=${request.dbName}");
    final db = sqliteWrapper.getDatabase(dbName: request.dbName);
    final res = db.select(request.sql, _unpack(request.params.toList()));
    return SqlQueryResponse(result: jsonEncode(res));
  }

  _unpack(List<Any> params) {
    return params.map((any) {
      if (any.typeUrl.endsWith('Int64Value')) {
        return any.unpackInto(Int64Value()).value.toInt();
      } else if (any.typeUrl.endsWith('StringValue')) {
        return any.unpackInto(StringValue()).value;
      } else if (any.typeUrl.endsWith('BoolValue')) {
        return any.unpackInto(BoolValue()).value;
      } else if (any.typeUrl.endsWith('DoubleValue')) {
        return any.unpackInto(DoubleValue()).value.toDouble();
      } else if (any.typeUrl == '') {
        return null;
      }
      throw ArgumentError('Unknown type: ${any.typeUrl}');
    }).toList();
  }

  @override
  Future<GetVersionResponse> getVersion(
      ServiceCall call, GetVersionRequest request) async {
    print("GetVersion called: dbName=${request.dbName}");
    final version = await sqliteWrapper.getVersion();
    // Replace with logic to retrieve the database version.
    return GetVersionResponse(version: version);
  }

  @override
  Future<SetVersionResponse> setVersion(
      ServiceCall call, SetVersionRequest request) async {
    print(
        "SetVersion called: dbName=${request.dbName}, version=${request.version}");
    await sqliteWrapper.setVersion(request.version);
    // Replace with logic to set the database version.
    return SetVersionResponse(success: true);
  }

  /// Echo method... used for testing
  @override
  Future<EchoResponse> echo(ServiceCall call, EchoRequest request) async {
    print("Echo called with message ${request.message}");
    return EchoResponse(message: request.message);
  }
}
