import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:grpc/grpc.dart';
import 'package:inject_x/inject_x.dart';
import 'package:sqlite_wrapper/generated/auth.pbgrpc.dart';
import 'package:sqlite_wrapper_server/constants.dart';
import 'package:sqlite_wrapper_server/services/authentication_service.dart';
import 'package:sqlite_wrapper_server/services/database_service.dart';

class AuthServiceImpl extends AuthServiceBase {
  final authenticationService = inject<AuthenticationService>();
  final databaseService = inject<DatabaseService>();
  @override
  Future<AuthResponse> register(
      ServiceCall call, RegisterRequest request) async {
    final dbName = Constants.usersDBName;
    if (await databaseService.emailAlreadyRegistered(request.email,
        dbName: dbName)) {
      return AuthResponse()
        ..success = false
        ..message = 'Email already registered';
    }

    await databaseService.insertUser(
        email: request.email, password: request.password, dbName: dbName);

    // Generate JWT token
    final token = authenticationService.generateToken(request.email);

    return AuthResponse()
      ..success = true
      ..message = 'Registration successful'
      ..token = token;
  }

  @override
  Future<AuthResponse> login(ServiceCall call, LoginRequest request) async {
    final dbName = Constants.usersDBName;
    if (!await databaseService.emailAlreadyRegistered(request.email,
        dbName: dbName)) {
      return AuthResponse()
        ..success = false
        ..message = 'User not found';
    }

    // Verify password

    if (!await databaseService.isLoginCorrect(
        email: request.email, password: request.password, dbName: dbName)) {
      return AuthResponse()
        ..success = false
        ..message = 'Invalid password';
    }

    // Generate JWT token
    final token = authenticationService.generateToken(request.email);

    return AuthResponse()
      ..success = true
      ..message = 'Login successful'
      ..token = token;
  }

  @override
  Future<ValidateTokenResponse> validateToken(
      ServiceCall call, ValidateTokenRequest request) async {
    try {
      JWT jwt = authenticationService.verifyToken(request.token);
      return ValidateTokenResponse()
        ..valid = true
        ..email = jwt.payload['email'] as String;
    } catch (e) {
      return ValidateTokenResponse()
        ..valid = false
        ..email = '';
    }
  }
}
