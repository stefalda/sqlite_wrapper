import 'package:sqlite_wrapper/generated/auth.pbgrpc.dart';

/// Example usage
///
// void main() async {
//   final client = AuthClient();

//   // Register a new user
//   final registered = await client.register('user@example.com', 'password123');
//   if (registered) {
//     print('Registration successful! Token: ${client.token}');
//   }

//   // Login
//   final loggedIn = await client.login('user@example.com', 'password123');
//   if (loggedIn) {
//     print('Login successful! Token: ${client.token}');
//   }

//   // Validate token
//   final isValid = await client.validateToken("sdasdas");
//   print('Token is valid: $isValid');
// }

class AuthClient {
  late AuthServiceClient _stub;
  //String? _token;

  AuthClient(dynamic channel) {
    _stub = AuthServiceClient(channel);
  }

  /// Returns the AuthResponse (token + refreshToken) or throws on error.
  Future<AuthResponse> register(String email, String password) async {
    try {
      final request = RegisterRequest()
        ..email = email
        ..password = password;

      final response = await _stub.register(request);
      if (response.success) {
        return response;
      }
      final err = ('Registration failed: ${response.message}');
      throw err;
    } catch (e) {
      final err = ('Error during registration: $e');
      throw err;
    }
  }

  /// Returns the AuthResponse (token + refreshToken) or throws on error.
  Future<AuthResponse> login(String email, String password) async {
    try {
      final request = LoginRequest()
        ..email = email
        ..password = password;

      final response = await _stub.login(request);
      if (response.success) {
        return response;
      }
      final err = ('Login failed: ${response.message}');
      throw err;
    } catch (e) {
      final err = ('Error during login: $e');
      throw err;
    }
  }

  /// Returns the AuthResponse (new token + new refreshToken) or throws on failure.
  Future<AuthResponse> refreshToken(String refreshToken) async {
    try {
      final request = RefreshTokenRequest()
        ..refreshToken = refreshToken;
      final response = await _stub.refreshToken(request);
      if (response.success) {
        return response;
      }
      final err = ('Token refresh failed: ${response.message}');
      throw err;
    } catch (e) {
      final err = ('Error during token refresh: $e');
      throw err;
    }
  }

  Future<bool> validateToken(String token) async {
    try {
      final request = ValidateTokenRequest()..token = token;
      final response = await _stub.validateToken(request);
      return response.valid;
    } catch (e) {
      //print('Error validating token: $e');
      return false;
    }
  }
}
