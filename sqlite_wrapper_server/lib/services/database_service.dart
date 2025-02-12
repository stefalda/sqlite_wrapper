import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  /// Open or create the users database
  Future<void> openDatabase(
      {required String path, required String name}) async {
    SQLiteWrapper().openDB("$path$name.sqlite", onCreate: () async {
      final sql = """CREATE TABLE IF NOT EXISTS users (
      id TEXT PRIMARY KEY DEFAULT (hex(randomblob(16))),
      email TEXT UNIQUE NOT NULL,
      password_hash TEXT NOT NULL,
      salt TEXT NOT NULL,
      created_at DATETIME DEFAULT current_timestamp
      );

      -- Create an index on the email column to improve lookup performance
      CREATE INDEX IF NOT EXISTS idx_email ON users(email);
      """;
      await SQLiteWrapper().execute(sql, dbName: name);
    }, dbName: name);
  }

  /// Check if the user email is already registered
  Future<bool> emailAlreadyRegistered(String email,
      {required String dbName}) async {
    final sql = "SELECT count(*) FROM users WHERE email = ?";
    int count = await SQLiteWrapper()
        .query(sql, params: [email], singleResult: true, dbName: dbName);
    return count > 0;
  }

  /// Inser a new user
  Future<void> insertUser(
      {required String email,
      required String password,
      required String dbName}) async {
    // Generate a random salt using secure methods or libraries like uuid.
    final salt = Uuid().v4();

    // Combine the salt with the password before hashing
    String digest = _getDigestValue(salt, password);

    // Current timestamp for created_at field
    //final createdAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    // Prepare the SQL statement with placeholders
    const sqlInsertUser =
        'INSERT INTO users (id, email, password_hash, salt) VALUES (?, ?, ?, ?);';

    // Use a UUID for the ID or let SQLite generate it if using `DEFAULT` in your table creation script.
    final id = Uuid().v7();

    try {
      await SQLiteWrapper().execute(
        sqlInsertUser,
        params: [
          id, // User's unique identifier
          email, // Email address (unique)
          digest, // Hashed password combined with salt
          salt // The generated salt for this user
        ],
        dbName: dbName,
      );
    } catch (e) {
      print('Error inserting user: $e');
    }
  }

  /// Check if the password matched the hashed one
  Future<bool> isLoginCorrect(
      {required String email,
      required String password,
      required String dbName}) async {
    const sql = 'SELECT salt, password_hash FROM users WHERE email = ?';
    final res = await SQLiteWrapper()
        .query(sql, params: [email], singleResult: true, dbName: dbName);
    // Check if a user was found
    if (res == null || res.length < 2) {
      return false; // No such user or incomplete data returned
    }

    final String salt = res[0];
    final storedDigest = res[1];
    final incomingDigest = _getDigestValue(salt, password);
    return _secureCompare(storedDigest, incomingDigest);
  }

  String _getDigestValue(String salt, String password) {
    // Combine the salt with the password before hashing
    final combinedPassword = '$salt$password';

    // Convert to UTF-8 and hash using SHA-256
    final bytes = utf8.encode(combinedPassword);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

// Constant-time string comparison function to prevent timing attacks
  bool _secureCompare(String a, String b) {
    if (a.length != b.length) {
      return false;
    }

    var result = 0;

    for (int i = 0; i < a.length; i++) {
      result |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }

    return result == 0;
  }

  closeDatabaseConnection() async {
    for (String dbName in SQLiteWrapper().getDatabases().getNames()) {
      SQLiteWrapper().closeDB(dbName: dbName);
    }
  }

  /// Return userId from email
  getUserId({required String email, required String dbName}) async {
    final sql = "SELECT id FROM users WHERE email = ?";
    return await SQLiteWrapper()
        .query(sql, params: [email], singleResult: true, dbName: dbName);
  }
}
