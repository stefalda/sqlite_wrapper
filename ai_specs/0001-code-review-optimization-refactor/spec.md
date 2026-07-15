---
type: Spec
title: Code Review – Optimization & Resilience Refactor
---

## Problem

The sqlite_wrapper library has accumulated technical debt across four areas: shared mutable static state that prevents safe concurrent use, a singleton pattern that conflicts with testability and DI, weak typing via `dynamic` that bypasses compiler checks, unfinished abstractions (`DatabaseCore` defined but unused), several paper-cut bugs (`fixBoolParams` mutation, silent error swallowing in `fromMap`, `getInstance()` factory calling itself recursively), missing transaction support, and a `closeDB` signature that is inconsistent between base and gRPC implementations. [L1]

## Proposed Outcome

A refactored library that is thread-safe by construction (per-instance state, no statics), dependency-injectable via `inject_x`, type-safe via a revived `DatabaseCore` abstract interface, consistent in its async signatures, resilient in error handling, and documented for the new patterns. The public API changes are deliberate and minimal — every breaking change eliminates a footgun or inconsistency. [L2]

## User Stories

1. As a library consumer, I want to register `SQLiteWrapperBase` once in my app's `main()` via `inject_x` and retrieve it with `inject<SQLiteWrapperBase>()` anywhere, so I no longer rely on a global singleton. [L4] [L5] [L13]

2. As a library consumer using `watch()` streams, I want stream state to be per-instance, so that multiple wrapper instances in tests do not leak or interfere with each other. [L4]

3. As a library consumer, I want `closeDB()` to be consistently async across all platforms, so I can `await` database closure and not worry about gRPC's different lifecycle. [L6]

4. As a library consumer, I want `execute()` to always return a non-nullable `Future`, so I never have to null-check the return value. [L7]

5. As a library consumer, I want a `transaction()` method that wraps `BEGIN`/`COMMIT`/`ROLLBACK` and only triggers stream updates on successful commit, so I don't see partial or rolled-back data in my reactive streams. [L10]

6. As a library consumer using `fromMap` in `query()`, I want mapping errors to propagate as exceptions instead of being silently swallowed and returning raw maps. [L11]

7. As a library consumer, I want column name sanitization so names passed as keys in `update`/`delete`/`save` cannot introduce SQL injection even when derived from external input. [L3]

## Requirements

### Instance State & DI

1. `SQLiteWrapperBase.streams` and `SQLiteWrapperBase.databases` are instance members, not `static`. Each `SQLiteWrapperBase` instance owns its own `Databases` and stream list. [L4]
2. `SQLiteWrapper` (the singleton) is deprecated with a `@Deprecated` annotation pointing to the `inject_x` replacement. Its implementation delegates to `SQLiteWrapperCore` as before, but new code should not use it. [L4]
3. A new dependency on `inject_x` is added to `pubspec.yaml`.
4. The `getInstance()` factory function in `sqlite_wrapper_factory.dart` is updated to call `InjectX.add<SQLiteWrapperBase>(SQLiteWrapperCore())` and return the registered instance. [L5]
5. Consumers who prefer explicit DI call `InjectX.add<SQLiteWrapperBase>(SQLiteWrapperCore())` in `main()` and then `inject<SQLiteWrapperBase>()` where needed. [L5]

### DatabaseCore Interface

6. `DatabaseCore` is promoted from an unused abstract class to the unified interface for all database backends. [L8]

```dart
abstract class DatabaseCore {
  Future<void> execute(String sql, List<Object?> params);
  Future<List<Map<String, dynamic>>> select(String sql, List<Object?> params);
  void dispose();
}
```

7. Each platform implements `DatabaseCore`:
   - **Mobile** (`sqlite3`): wraps synchronous `db.select()` in `Future(() => ...)`.
   - **Web** (`sqflite_ffi_web`): delegates to `rawQuery()` (already async).
   - **gRPC**: delegates to `SqliteServiceClientWrapper.select()` (already async).
8. `Databases._dbs` changes from `Map<String, dynamic>` to `Map<String, DatabaseCore>`. The `get()` method returns `DatabaseCore?`. The `add()` method accepts `DatabaseCore`. [L8]
9. `_getDB()` in `SQLiteWrapperBase` returns `DatabaseCore` instead of `dynamic`.
10. `getDatabase({String? dbName})` return type changes from `dynamic` to `DatabaseCore?`, consistent with `Databases.get()`. This preserves the escape hatch without the untyped `dynamic`.
11. The `isWeb()` branch in `query()` is removed. All platforms go through `await db.select(sql, params)`.

### SqliteWrapperInterface

12. `SqliteWrapperInterface` is updated to match the new signatures: [L6] [L7]
    - `closeDB()` → `Future<void> closeDB({String? dbName})`
    - `execute()` → `Future<dynamic> execute(...)` (non-nullable)
    - `getDatabase()` → `DatabaseCore? getDatabase({String? dbName})`
13. The commented-out method block (lines 26–65) is removed — those methods are already declared by the concrete class `SQLiteWrapperBase`.

### closeDB

14. `closeDB({String? dbName})` changes return type from `void` to `Future<void>`. The base implementation awaits `databases.get(name).dispose()`. The gRPC override already returns a Future. [L6]

### execute Return Type

15. `execute()` return type changes from `Future<dynamic>?` to `Future<dynamic>`. The method no longer returns null. [L7]

### fixBoolParams

16. `fixBoolParams` does not mutate the input list. It returns a new `List<Object?>` with booleans converted to integers (true→1, false→0). [L9]

### Transaction Support

17. A new `transaction()` method is added to `SQLiteWrapperBase`: [L10]

```dart
Future<T> transaction<T>(Future<T> Function() action, {String? dbName});
```

18. `transaction()` executes `BEGIN`, runs `action()`, then:
    - On success: `COMMIT` followed by `updateStreams()` called with `null` (all tables). The `updateStreams` behavior for `null` changes from "skip all" to "refresh all".
    - On exception: `ROLLBACK`; the exception propagates; `updateStreams` is NOT called.
19. Nested transactions are not supported. Calling `transaction()` inside `action()` throws `StateError`.

### fromMap Error Handling

20. In `query()`, if `fromMap` throws, the exception propagates to the caller. The `print(error)` + silent-return-fallback pattern is removed. [L11]

### Column Name Sanitization

21. In `_getWhereClause()`, `update()`, `delete()`, and `_insertOrUpdate()`, column names passed via `keys` are sanitized before interpolation. Sanitization rejects names that do not match `^[a-zA-Z_][a-zA-Z0-9_]*$`. [L3]

### Web `:memory:` Support

22. The web `openDB` implementation removes the `throw UnimplementedError()` for `:memory:` path. The `databaseFactoryFfiWeb.openDatabase()` call handles in-memory databases natively.

### Source Cleanup

23. `library sqlite_wrapper;` declarations are removed from all source files. This is a Dart 2 convention that is now optional and ignored by modern Dart.

### Documentation

24. `README.md` is updated to reflect:
    - New DI pattern with `inject_x`.
    - Deprecation of `SQLiteWrapper` singleton.
    - `closeDB()` now returns `Future<void>` (use `await`).
    - New `transaction()` method.
    - Updated example code.
25. The `/example` code is updated to use the new patterns.

## Technical Decisions

- `inject_x` is added as a hard dependency (not dev dependency) because `getInstance()` calls `InjectX.add()`.
- `SQLiteWrapper` is deprecated but kept to avoid breaking existing `sync_client` consumers immediately. `sync_client` depends on `sqlite_wrapper ^0.2.3` and will need an update to use the new DI patterns.
- The `DatabaseCore.select()` return type is `Future<List<Map<String, dynamic>>>` — consistent with what all backends already produce.
- The `transaction()` method returns `Future<T>` so the caller can retrieve a value from inside the transaction (e.g., a generated ID).
- The `closeDB()` on gRPC is already async; the change only affects the base class signature and the mobile/web implementations (which become async trivially via `Future.value()` or wrapping in `Future(() => ...)`).
- `updateStreams(null)` behavior changes: instead of "skip all", it refreshes all active streams. This ensures `transaction()` can trigger a full refresh without needing per-action table tracking.

## Testing Strategy

- **Existing tests** in `test/sqlite_wrapper_test.dart` must pass after the refactor with minimal changes (primarily replacing `SQLiteWrapper()` singleton calls with `inject<SQLiteWrapperBase>()` or direct `SQLiteWrapperCore()` construction in tests).
- **New tests for:**
  - `transaction()`: verify commit updates streams, rollback does not.
  - `fixBoolParams`: verify input list is not mutated, output has ints instead of bools.
  - Column sanitization: verify injection attempts are rejected.
  - `fromMap` error propagation: verify exception is thrown.
  - `closeDB()` Future: verify it completes.
- **Test seam:** Tests can instantiate `SQLiteWrapperCore` directly with `:memory:` path and `SQLiteWrapperBase.databases` is per-instance. No need for DI in tests unless testing the DI integration itself.

## Out of Scope

- Async factories in `registerAsync` or lazy registration via `InjectX` — not needed for the single-instance use case.
- Removing the `getDatabase()` public accessor — kept for backward compatibility (return type updated to `DatabaseCore?`).
- Replacing the `StreamController` with a more sophisticated reactive system — the current approach works for the library's scope.
- Full `sync_client` migration — `sync_client` will be updated in a follow-up after this Spec is released.
- `library sqlite_wrapper;` declarations in source files — handled in Requirements #22.

## Follow-Ups

- Publish a new minor version (`0.4.0`) given the breaking changes.
- Update `sync_client` to work with the new API once published.
