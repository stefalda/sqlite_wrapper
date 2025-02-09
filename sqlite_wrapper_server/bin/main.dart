import 'package:grpc/grpc.dart';
import 'package:sqlite_wrapper_server/sqlite_wrapper_server.dart';

Future<void> main(List<String> args) async {
  // Create the gRPC server with the service implementation and authentication interceptor.
  final server = Server(
    [SqliteServiceImpl()],
    //  [AuthInterceptor()],
  );

  // Start the server on port 50051 without TLS.
  await server.serve(port: 50051);
  print('SQLiteWrapper gRPC server listening on port ${server.port}');
}
