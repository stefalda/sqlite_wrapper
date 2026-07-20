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
      params: convertParamsToParam(params),
      dbName: dbName,
    ));
  }

  @override
  Future<List<Map<String, dynamic>>> select(
      String sql, List<Object?> params) async {
    final response = await client.select(SqlQueryRequest(
      sql: sql,
      params: convertParamsToParam(params),
      dbName: dbName,
    ));
    return mapsFromRows(response.rows.toList());
  }

  @override
  void close() {}
}
