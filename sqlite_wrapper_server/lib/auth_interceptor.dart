import 'package:grpc/grpc.dart';
import 'package:inject_x/inject_x.dart';
import 'package:sqlite_wrapper_server/constants.dart';
import 'package:sqlite_wrapper_server/services/authentication_service.dart';
import 'package:sqlite_wrapper_server/services/database_service.dart';
import 'package:sqlite_wrapper_server/sqlite_wrapper_server.dart';

final publicPaths = {
  '/auth.AuthService/Register',
  '/auth.AuthService/Login',
  '/sqlite_wrapper.SqliteWrapperService/Echo'
};

Future<GrpcError?> authInterceptor(
  ServiceCall call,
  ServiceMethod method,
) async {
  final String currentPath = call.clientMetadata![':path']!;
  // print("Checking authentication for $currentPath");
  // Check if the method is unhautenticated
  if (SQLiteWrapperServerImpl.runUnauthenticated ||
      publicPaths.contains(currentPath)) {
    return null;
  }
  final metadata = call.clientMetadata ?? {};
  final idToken = metadata['token'];
  if (idToken == null) {
    return GrpcError.unauthenticated('Missing Auth Token');
  }
  final authenticationService = inject<AuthenticationService>();
  try {
    final jwt = authenticationService.verifyToken(idToken);
    // Add the email to the metadata
    final String email = authenticationService.extractEmailFromJWT(jwt);
    call.clientMetadata!['email'] = email;
    // Add the uuid too
    final uuid = await inject<DatabaseService>()
        .getUserId(email: email, dbName: Constants.usersDBName);
    call.clientMetadata!['user_uuid'] = uuid;
  } catch (e) {
    return GrpcError.unauthenticated();
  }
  return null;
}
