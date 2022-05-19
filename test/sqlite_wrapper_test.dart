import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';

import 'user.dart';

const String inMemoryDatabasePath = ':memory:';

_createTableAndInsertSampleValues({createOnly = false}) async {
  await SQLiteWrapper().execute("""
      CREATE TABLE IF NOT EXISTS "users" (
          "id" integer PRIMARY KEY AUTOINCREMENT NOT NULL,
          "name" varchar(128) NOT NULL
        );
        DELETE FROM users;
        UPDATE `sqlite_sequence` SET `seq` = 0 WHERE `name` = 'users';
        PRAGMA schema_version=0;
        """);
  if (createOnly) return;
  await SQLiteWrapper().execute("INSERT INTO users (name) VALUES ('Paperino')");
  List<Map> users = await SQLiteWrapper().query("SELECT * FROM users");
  expect(users.length, 1);
  await SQLiteWrapper().execute("INSERT INTO users (name) VALUES ('Pippo')");
}

void main() async {
  final sqlWrapper = SQLiteWrapper();

  test('create and test it\'s a singleton', () {
    expect(sqlWrapper, isNot(null));
    final secondWrapper = SQLiteWrapper();
    expect(sqlWrapper, equals(secondWrapper));
  });

  test('create a DB instance and check for version', () async {
    expect(await sqlWrapper.getVersion(), 0);
    // Set version
    await sqlWrapper.setVersion(1);
    // Check version
    expect(await sqlWrapper.getVersion(), 1);
  });

  group('DB operations', () {
    test('create a table and select from it', () async {
      await sqlWrapper.execute("""
      CREATE TABLE IF NOT EXISTS "users_test" (
          "id" integer PRIMARY KEY AUTOINCREMENT NOT NULL,
          "name" varchar(128) NOT NULL
        );
        """);

      List<Map> users = await sqlWrapper.query("SELECT * FROM users_test");
      expect(users.length, 0);
      await sqlWrapper.execute("DROP TABLE users_test;");
    });

    test('INSERT in table AND CHECK inserted values', () async {
      await _createTableAndInsertSampleValues(createOnly: true);
      await sqlWrapper.execute("INSERT INTO users (name) VALUES ('Paperino')");
      List<Map> users = await sqlWrapper.query("SELECT * FROM users");
      expect(users.length, 1);
      await sqlWrapper.execute("INSERT INTO users (name) VALUES ('Pippo')");

      final Map? userMap = await sqlWrapper.query(
          "SELECT * FROM users WHERE name = 'Paperino'",
          singleResult: true);
      expect(userMap!['name'], 'Paperino');
    });

    test('SELECT converting data to Model objects', () async {
      await _createTableAndInsertSampleValues();
      // Now try to convert to a User object
      final User user = await sqlWrapper.query(
          "SELECT * FROM users WHERE name = ?",
          params: ["Paperino"],
          fromMap: User.fromMap,
          singleResult: true);
      expect(user.id, 1);

      // Find something not exisitng
      final User? missingUser = await sqlWrapper.query(
          "SELECT * FROM users WHERE name = ?",
          params: ["Topolino"],
          fromMap: User.fromMap,
          singleResult: true);
      expect(missingUser, null);

      // Return a list of users
      List<User> allUsers = List<User>.from(await sqlWrapper.query(
          "SELECT * from users order by name DESC",
          fromMap: User.fromMap));
      expect(allUsers.length, 2);
      expect(allUsers.first.name, "Pippo");
    });

    test("Extract a single field from Table", () async {
      await _createTableAndInsertSampleValues();
      // Return a list of ids
      List<int> ids =
          List<int>.from(await sqlWrapper.query("SELECT id from users"));
      expect(ids.length, 2);
      expect(ids[0], 1);
      // Select just the id of a Record
      final int? id = await sqlWrapper.query(
        "SELECT id FROM users WHERE name = ?",
        params: ["Paperino"],
        singleResult: true,
      );
      expect(id, 1);
      // Create a count
      final int count = await sqlWrapper.query("SELECT COUNT(*) FROM users",
          singleResult: true);
      expect(count, 2);
    });

    test("Update a table value", () async {
      await _createTableAndInsertSampleValues();
      User user = await sqlWrapper.query("SELECT * FROM users WHERE id=?",
          params: ["2"], singleResult: true, fromMap: User.fromMap);
      expect(user.name, "Pippo");
      await sqlWrapper.execute("UPDATE users SET name=? WHERE id = ?",
          params: ["Topolino", "2"]);
      user = await sqlWrapper.query("SELECT * FROM users WHERE id=?",
          params: ["2"], singleResult: true, fromMap: User.fromMap);
      expect(user.name, "Topolino");
      // Now go back by using simplified methods
      user.name = "Pippo";
      await sqlWrapper.update(user.toMap(), "users", keys: ["id"]);
      user = await sqlWrapper.query("SELECT * FROM users WHERE id=?",
          params: ["2"], singleResult: true, fromMap: User.fromMap);
      expect(user.name, "Pippo");
    });

    test("INSERT a new record in the table", () async {
      await _createTableAndInsertSampleValues();
      User user = User();
      user.name = "Paperone";
      user.id = await sqlWrapper.insert(user.toMap(), "users");
      user = await sqlWrapper.query("SELECT * FROM users WHERE id=?",
          params: [user.id], singleResult: true, fromMap: User.fromMap);
      expect(user.name, "Paperone");
    });

    test("DELETE a record from the table", () async {
      await _createTableAndInsertSampleValues();
      User user = await sqlWrapper.query("SELECT * FROM users WHERE id=?",
          params: [1], singleResult: true, fromMap: User.fromMap);
      expect(user.name, "Paperino");
      final res = await sqlWrapper.delete(user.toMap(), "users", keys: ["id"]);
      expect(res, 1);
    });
  });

  // STREAM
  group("DB STREAM", () {
    test("WATCH A SIMPLE VALUE", () async {
      await _createTableAndInsertSampleValues();
      Stream stream = SQLiteWrapper().watch("SELECT COUNT(*) FROM users",
          singleResult: true, tables: ["users"]);
      // Add a user
      User user = User();
      user.name = "Paperone";
      sqlWrapper.insert(user.toMap(), "users");
      // Delete a user
      sqlWrapper.execute('DELETE FROM users WHERE id=1', tables: ['users']);
      expect(stream, emitsInOrder([2, 3, 2]));
      //
      /*
      stream.listen((event) {
        expect(event, 2);
        // Add a user
        User user = User();
        user.name = "Paperone";
        sqlWrapper.insert(user.toMap(), "users");

        // First async event
        expectAsync1((event) {
          expect(event, 0);
        });
      });
              */
    });

    test("Watch a list of resultsets", () async {
      await _createTableAndInsertSampleValues();
      Stream<ResultSet> userStream = Stream.castFrom(SQLiteWrapper().watch(
          "SELECT * FROM users",
          singleResult: false,
          tables: ["users"]));
      expect(
          userStream,
          emitsInOrder([
            [
              {"id": 1, "name": "Paperino"},
              {"id": 2, "name": "Pippo"}
            ]
          ]));
    });

    test("Watch a list of objects", () async {
      await _createTableAndInsertSampleValues();
      Stream userStream = SQLiteWrapper().watch("SELECT * FROM users",
          singleResult: false, fromMap: User.fromMap, tables: ["users"]);
      expect(
          userStream,
          emitsInOrder([
            [
              User()
                ..id = 1
                ..name = "Paperino",
              User()
                ..id = 2
                ..name = "Pippo"
            ]
          ]));
    });
  });
}
