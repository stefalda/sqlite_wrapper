import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:sqlite_wrapper_server/constants.dart';

class AuthenticationService {
  final String _jwtSecret = Constants.secretKey;

  JWT verifyToken(String token) {
    return JWT.verify(token, SecretKey(_jwtSecret));
  }

  /// Return the email in the verified JWT
  String extractEmailFromJWT(JWT jwt) {
    return jwt.payload['email'] as String;
  }

  /// Genereate the token and return to user
  String generateToken(String email) {
    final jwt = JWT(
      {
        'email': email,
        'iat': DateTime.now().millisecondsSinceEpoch,
      },
    );
    return jwt.sign(SecretKey(_jwtSecret));
  }
}
