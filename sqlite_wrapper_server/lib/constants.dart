/// Environment variables and shared app constants.
///
/// You can pass the value like this:
///
/// --define=SERVER_PORT=50012
/// --define=RUN_UNATHENTICATED=false
/// --define=SECRET_KEY=a1b2c33d4e5f6g7h8i9jakblc
///
///
/// In VSCode you can pass the parameters in the launch.json file like this:
///
///        {
///            "name": "Dart",
///            "type": "dart",
///            "request": "launch",
///            "program": "bin/main.dart",
///            "toolArgs": [
///                "--define=SERVER_PORT=50012",
///                "--define=RUN_UNATHENTICATED=false",
///                "--define=SECRET_KEY=a1b2c33d4e5f6g7h8i9jakblc"]
///        }
///
///
///
library;

abstract class Constants {
  /// Listeninf Port of the server
  static const String serverPort = String.fromEnvironment(
    'SERVER_PORT',
    defaultValue: '50051',
  );

  /// Secret uset to generate JWT Keys
  static const String secretKey = String.fromEnvironment(
    'SECRET_KEY',
    defaultValue: '',
  );

  /// Calls are unauthenticated so there's no USERS DB
  static const String runUnathenticated = String.fromEnvironment(
    'RUN_UNATHENTICATED',
    defaultValue: 'false',
  );

  /// Name of the database of authenticated users
  static const String usersDBName = String.fromEnvironment(
    'USERS_DB_NAME',
    defaultValue: 'users',
  );

  /// Path to the authenticated users DB
  static const String usersDBPath = String.fromEnvironment(
    'USERS_DB_PATH',
    defaultValue: './',
  );

  /// Path to where the application DB is stored
  static const String dbPath = String.fromEnvironment(
    'DB_PATH',
    defaultValue: './',
  );

  /// If a DB is shared there will be only ONE DB for all the users
  /// otherwise every DB will be specific to a user
  static const String sharedDB = String.fromEnvironment(
    'SHARED_DB',
    defaultValue: 'false',
  );
}
