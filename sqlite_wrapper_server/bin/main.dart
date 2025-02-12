import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:inject_x/inject_x.dart';
import 'package:sqlite_wrapper_server/auth_interceptor.dart';
import 'package:sqlite_wrapper_server/auth_server.dart';
import 'package:sqlite_wrapper_server/constants.dart';
import 'package:sqlite_wrapper_server/services/authentication_service.dart';
import 'package:sqlite_wrapper_server/services/database_service.dart';
import 'package:sqlite_wrapper_server/sqlite_wrapper_server.dart';

Future<void> main(List<String> args) async {
  // Load the service
  final databaseService = InjectX.add(DatabaseService());
  InjectX.add(AuthenticationService());

  // Create the gRPC server with the service implementation and authentication interceptor.
  final server = Server.create(
      services: [SQLiteWrapperServerImpl(), AuthServiceImpl()],
      interceptors: [authInterceptor]);

  // Start the server on port 50051 without TLS.
  final port = int.parse(Constants.serverPort);
  await server.serve(port: port);
  // Disable token authentication
  SQLiteWrapperServerImpl.runUnauthenticated =
      (Constants.runUnathenticated == "true");

  if (!SQLiteWrapperServerImpl.runUnauthenticated) {
    // Check that the secret key is set
    assert(Constants.secretKey.isNotEmpty,
        "The secret key has not be set, please pass it with define");
  }
  // Open or create the user DB
  await databaseService.openDatabase(
      path: Constants.usersDBPath, name: Constants.usersDBName);

// Handle program termination (Ctrl+C or process kill)
  ProcessSignal.sigint.watch().listen((_) async {
    print("Received SIGINT, closing database...");
    await databaseService.closeDatabaseConnection();
    exit(0); // Ensure program exits after cleanup
  });

  ProcessSignal.sigterm.watch().listen((_) async {
    print("Received SIGTERM, closing database...");
    await databaseService.closeDatabaseConnection();
    exit(0);
  });

  print('SQLiteWrapper gRPC server listening on port ${server.port}');
}
