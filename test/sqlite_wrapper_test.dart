//import 'package:flutter_test/flutter_test.dart';
import 'dart:async';
import 'dart:io';

import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite_wrapper/sqlite_wrapper.dart';
import 'package:sqlite_wrapper/sqlite_wrapper_base.dart';
import 'package:test/test.dart';

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

void main() {
  setUp(() async {
    SQLiteWrapper().openDB(inMemoryDatabasePath);
  });

  tearDown(() async {
    SQLiteWrapper().closeDB();
  });

  final sqlWrapper = SQLiteWrapper();

  test('create and test it\'s a singleton', () {
    expect(sqlWrapper, isNot(null));
    final secondWrapper = SQLiteWrapper();
    expect(sqlWrapper, equals(secondWrapper));
  });

  test('open a secondary database and perform a migration', () async {
    const dbName = "secondaryDB";
    await SQLiteWrapper().openDB(inMemoryDatabasePath,
        version: 1, dbName: dbName, onCreate: () async {
      await SQLiteWrapper().execute("""
      CREATE TABLE characters ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL,
          "name" varchar(128) NOT NULL);
      INSERT INTO characters (name) VALUES ('Donald Duck');
      INSERT INTO characters (name) VALUES ('Mickey Mouse');
      """, dbName: dbName);
    }, onUpgrade: (fromVersion, toVersion) async {
      if (fromVersion == 0 && toVersion == 1) {
        await SQLiteWrapper().execute("""
          ALTER TABLE characters ADD COLUMN "animal" varchar(128);
          UPDATE characters SET animal = 'DUCK' WHERE id = 1;
          UPDATE characters SET animal = 'MOUSE' WHERE id = 2;
          """, dbName: dbName);
      }
    });
    final int count = await SQLiteWrapper().query(
        "SELECT COUNT(*) FROM characters WHERE animal='DUCK'",
        singleResult: true,
        dbName: dbName);
    expect(count, 1);
    expect(await SQLiteWrapper().getVersion(dbName: dbName), 1);
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

    test("Create an upsert instead on an INSERT", () async {
      await _createTableAndInsertSampleValues();
      User user = User();
      user.name = "Paperone";
      user.id = await sqlWrapper.insert(user.toMap(), "users");
      // Now save again to get an error
      user.name = "Archimede";
      expect(() async => await sqlWrapper.insert(user.toMap(), "users"),
          throwsException);
      //Now save with an upsert
      await sqlWrapper.save(user.toMap(), "users", keys: ["id"]);
      user = await sqlWrapper.query("SELECT * FROM users WHERE id=?",
          params: [user.id], singleResult: true, fromMap: User.fromMap);
      expect(user.name, "Archimede");
      // And perform a new INSERT
      User user2 = User();
      user2.name = "Paperone";
      user2.id = await sqlWrapper.save(user2.toMap(), "users", keys: ["id"]);
      user = await sqlWrapper.query("SELECT * FROM users WHERE id=?",
          params: [user2.id], singleResult: true, fromMap: User.fromMap);
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

  test("Check if the stream is removed by the streams array", () async {
    await _createTableAndInsertSampleValues();
    Stream userStream = SQLiteWrapper().watch("SELECT * FROM users",
        singleResult: false, fromMap: User.fromMap, tables: ["users"]);
    // Check if the stream has been added to the array
    expect(SQLiteWrapperBase.streams.length, 1);

    final StreamSubscription sub = userStream.listen((event) {});

    await sub.cancel();

    expect(SQLiteWrapperBase.streams.length, 0);
  });

  test("Create one or more subfolders in the base folder to store the DB",
      () async {
    const String path =
        "./59976040-a675-11ec-8ee4-1f922f66b681/test2/prova.sqlite";
    const dbName = "TESTDB";
    SQLiteWrapper().openDB(path, dbName: dbName);
    File f = File.fromUri(Uri(path: path));
    expect(f.existsSync(), true);
    SQLiteWrapper().closeDB(dbName: dbName);
    f = File.fromUri(Uri(path: "./59976040-a675-11ec-8ee4-1f922f66b681"));
    f.deleteSync(recursive: true);
  });

  test('Update and delete from a table with multiple primary keys', () async {
    const dbName = "thirdDB";
    await SQLiteWrapper().openDB(inMemoryDatabasePath,
        version: 1, dbName: dbName, onCreate: () async {
      await SQLiteWrapper().execute("""
      CREATE TABLE IF NOT EXISTS "Characters" (
          "id" integer NOT NULL,
          "name" varchar(100) NOT NULL,
          "description" text,
          PRIMARY KEY("id", "name")
        );
      INSERT INTO characters (id, name, description) VALUES (1, 'Donald Duck', 'Paperino');
      INSERT INTO characters (id, name, description) VALUES (2, 'Mickey Mouse', 'Topolino');
      """, dbName: dbName);
    });

    // PERFORM UPDATE
    await SQLiteWrapper().update(
        {"description": "Paperino modificato", "id": 1, "name": "Donald Duck"},
        "characters",
        keys: ["id", "name"],
        dbName: dbName);
    final String description = await SQLiteWrapper().query(
        "SELECT description FROM characters WHERE id=1 AND name='Donald Duck'",
        singleResult: true,
        dbName: dbName);
    expect(description, "Paperino modificato");

    // PERFORM DELETE
    await SQLiteWrapper().delete(
        {"description": "Paperino modificato", "id": 1, "name": "Donald Duck"},
        "characters",
        keys: ["id", "name"],
        dbName: dbName);
    final int count = await SQLiteWrapper().query(
        "SELECT COUNT(*) FROM characters WHERE name='Donald Duck'",
        singleResult: true,
        dbName: dbName);
    expect(count, 0);
    expect(await SQLiteWrapper().getVersion(dbName: dbName), 1);
  });
}
