# sqlite_wrapper Glossary

Project-specific terminology for the sqlite_wrapper Dart/Flutter library.

## Terminology

**SQLiteWrapperBase**:
The abstract base class that implements all core logic: `execute`, `query`, `watch`, `insert`, `update`, `delete`, `save`, stream management, and database lifecycle.
_Avoid_: calling it "the wrapper" (ambiguous with the package itself)

**SQLiteWrapperCore**:
The platform-specific subclass of SQLiteWrapperBase. One implementation exists per platform (mobile via `sqlite3`, web via `sqflite_ffi_web`, stub). This is the class consumers instantiate or extend.
_Avoid_: SQLiteWrapper (the deprecated singleton)

**SQLiteWrapper**:
The deprecated singleton class that wraps SQLiteWrapperCore. Replaced by `inject_x` dependency injection.
_Avoid_: using it in new code

**DatabaseCore**:
The unified abstract interface for a single database connection. Defines `execute`, `select`, and `close`. Implemented per-platform (native sqlite3, sqflite_ffi_web, gRPC client wrapper). Used as the type parameter in `Databases` instead of `dynamic`.
_Avoid_: dynamic database references

**Databases**:
The multi-connection manager that maps `dbName` strings to `DatabaseCore` instances. Owned by a single SQLiteWrapperBase instance (no longer static).

**StreamInfo**:
The internal record that tracks a `watch()` subscription: its SQL, parameters, table list, optional `fromMap` mapper, and its `StreamController`. Stored per-instance.

**FromMap**:
The typedef `dynamic Function(Map<String, dynamic>)` used by `query()` and `watch()` to convert raw result maps into typed model objects. Named after the `fromMap` factory constructor convention.

**OnCreate** / **OnUpgrade**:
Callbacks passed to `openDB()`. `OnCreate` fires when a database is opened for the first time. `OnUpgrade(fromVersion, toVersion)` fires when `version` changes, used for schema migrations.

**SqliteWrapperGRPC**:
The gRPC subclass of `SQLiteWrapperBase`. Created via `SqliteWrapperGRPC.withHostAndPort(host, port, secure)`. Delegates all database operations to a remote `sqlite_wrapper_server` via gRPC. Exposes `authClient` for authentication.
_Avoid_: using it for local databases

**GrpcServiceManager**:
Manages the gRPC `ClientChannel` and lazily initializes `AuthClient` and `SqliteWrapperServiceClient`. Created internally by `SqliteWrapperGRPC`.

**AuthClient**:
Wraps the generated `AuthServiceClient` gRPC stub. Provides `register(email, password)`, `login(email, password)`, and `validateToken(token)` methods. Accessible via `SqliteWrapperGRPC.authClient`.

**SqliteServiceClientWrapper**:
Implements `DatabaseCore` by forwarding `execute()` and `select()` calls to the gRPC `SqliteWrapperServiceClient`. Created internally when `SqliteWrapperGRPC.openDB()` is called.
