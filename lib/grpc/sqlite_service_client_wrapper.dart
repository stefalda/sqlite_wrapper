import 'dart:convert';
import 'dart:typed_data';

import 'package:sqlite_wrapper/grpc/grpc_helper.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';

/// DatabaseCore implementation that communicates via gRPC.
///
/// Wraps the gRPC client to provide the [DatabaseCore] interface.
/// Used for `select` calls from the base [query] method;
/// `execute` is overridden by [SQLiteWrapperGRPC] and does not reach here.
class SqliteServiceClientWrapper implements DatabaseCore {
  final SqliteWrapperServiceClient client;
  final String dbName;

  SqliteServiceClientWrapper({
    required this.client,
    required this.dbName,
  });

  @override
  Future<void> execute(String sql, List<Object?> params) async {
    await client.execute(SqlQueryRequest(
      sql: sql,
      params: convertParamsToAny(params),
      dbName: dbName,
    ));
  }

  /// Recursively convert JSON-decoded values in [map] back to [Uint8List]
  /// for any column whose value is a list of integers (JSON-encoded BLOB).
  void _convertBlobs(Map<String, dynamic> map) {
    for (final key in map.keys) {
      final value = map[key];
      if (value is List && value.isNotEmpty && value.first is int) {
        map[key] = Uint8List.fromList(value.cast<int>());
      }
    }
  }

  @override
  Future<List<Map<String, dynamic>>> select(
      String sql, List<Object?> params) async {
    final response = await client.select(SqlQueryRequest(
      sql: sql,
      params: convertParamsToAny(params),
      dbName: dbName,
    ));
    final result = jsonDecode(response.result);
    final maps = (result is List)
        ? result.cast<Map<String, dynamic>>()
        : List<Map<String, dynamic>>.from(result as List);
    for (final map in maps) {
      _convertBlobs(map);
    }
    return maps;
  }

  @override
  void close() {}
}
