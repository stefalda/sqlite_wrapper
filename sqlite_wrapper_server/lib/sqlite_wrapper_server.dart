import 'dart:convert';

import 'package:grpc/grpc.dart';
import 'package:inject_x/inject_x.dart';
import 'package:sqlite_wrapper/generated/google/protobuf/any.pb.dart';
import 'package:sqlite_wrapper/generated/google/protobuf/wrappers.pb.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';
import 'package:sqlite_wrapper_server/constants.dart';
import 'package:sqlite_wrapper_server/services/database_service.dart';

/// Implementation of the SqliteService defined in your sqlite.proto.
class SQLiteWrapperServerImpl extends SqliteWrapperServiceBase {
  static final List<StreamInfo> streams = [];
  final sqliteWrapper = SQLiteWrapperCore();
  final databaseService = inject<DatabaseService>();

  /// The DB Name is created appending to the dbName the user UUID
  String _getDBName({required ServiceCall call, required String dbName}) {
    final String? uuid = call.clientMetadata!['user_uuid'];
    if (uuid == null) {
      if (Constants.sharedDB == "true") {
        return dbName;
      } else {
        throw ("Something is wrong... why isn't the user logged in?");
      }
    }
    return "${dbName}_$uuid";
  }

  String _getDBPath(String dbName) {
    String dbPath = Constants.dbPath;
    return "$dbPath/$dbName.sqlite";
  }

  // Allow all connections without token authentication
  static bool runUnauthenticated = false;
  @override
  Future<OpenDBResponse> openDB(ServiceCall call, OpenDBRequest request) async {
    //TODO remove request and response path... or decide if the DB Name should be passed
    final String dbName = _getDBName(call: call, dbName: request.dbName);

    print(
        "OpenDB called: path=${request.path}, version=${request.version}, dbName=$dbName");

    final res = await sqliteWrapper.openDB(_getDBPath(dbName),
        version: request.version); //dbName: dbName,

    sqliteWrapper.closeDB();

    // Dummy response; replace with actual database opening logic.
    return OpenDBResponse(
        created: res.created,
        version: res.version,
        sqliteVersion: res.sqliteVersion,
        dbName: dbName);
  }

  @override
  Future<CloseDBResponse> closeDB(
      ServiceCall call, CloseDBRequest request) async {
    final String dbName = _getDBName(call: call, dbName: request.dbName);
    sqliteWrapper.closeDB(dbName: dbName);
    print("CloseDB called: dbName=$dbName");
    return CloseDBResponse(success: true);
  }

  @override
  Future<SqlQueryResponse> execute(
      ServiceCall call, SqlQueryRequest request) async {
    final String dbName = _getDBName(call: call, dbName: request.dbName);
    print(
        "Execute called: sql=${request.sql}, params=${request.params}, dbName=$dbName");
    await sqliteWrapper.openDB(_getDBPath(dbName));
    final res = await sqliteWrapper.execute(
      request.sql,
      params: _unpack(request.params.toList()),
    );
    sqliteWrapper.closeDB();

    // Replace with actual SQL command execution.
    return SqlQueryResponse(result: jsonEncode(res));
  }

  @override
  Future<SqlQueryResponse> select(
      ServiceCall call, SqlQueryRequest request) async {
    final String dbName = _getDBName(call: call, dbName: request.dbName);
    print(
        "Select called: sql=${request.sql}, params=${request.params}, dbName=$dbName");
    await sqliteWrapper.openDB(_getDBPath(dbName));
    final db = sqliteWrapper.getDatabase(); //dbName: dbName
    final res = db.select(
        request.sql, _unpack(request.params.toList())); // dbName: dbName
    sqliteWrapper.closeDB();
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
    final String dbName = _getDBName(call: call, dbName: request.dbName);

    print("GetVersion called: dbName=$dbName");
    await sqliteWrapper.openDB(_getDBPath(dbName));
    final version = await sqliteWrapper.getVersion();
    sqliteWrapper.closeDB();
    // Replace with logic to retrieve the database version.
    return GetVersionResponse(version: version);
  }

  @override
  Future<SetVersionResponse> setVersion(
      ServiceCall call, SetVersionRequest request) async {
    final String dbName = _getDBName(call: call, dbName: request.dbName);
    print("SetVersion called: dbName=$dbName, version=${request.version}");
    await sqliteWrapper.openDB(_getDBPath(dbName));
    await sqliteWrapper.setVersion(request.version);
    sqliteWrapper.closeDB();
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
