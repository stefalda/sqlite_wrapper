import 'dart:convert';

import 'package:sqlite_wrapper/grpc/grpc_helper.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';

/// This class is a wrapper around the client
/// used to provide the select method
/// that is expected in the SQLiteWrapper code
class SqliteServiceClientWrapper {
  final SqliteWrapperServiceClient client;
  final String dbName;

  SqliteServiceClientWrapper({required this.client, required this.dbName});

  Future<dynamic> select(String sql, List<Object?> params) async {
    final response = await client.select(SqlQueryRequest(
        sql: sql, params: convertParamsToAny(params), dbName: dbName));
    return jsonDecode(response.result);
  }
}
