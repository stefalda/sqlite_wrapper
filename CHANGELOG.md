## 0.5.5
Bugfix: `SqliteServiceClientWrapper.select()` now correctly converts JSON-encoded BLOB data (arrays of integers) back to `Uint8List` for all platforms, fixing cover image reads on web and other platforms.

## 0.5.4

- Added `BytesValue` support in `convertParamsToAny()` for `Uint8List` (binary)
  parameters sent via gRPC, enabling cover image inserts on web.
- `SqliteServiceClientWrapper.select()` now converts JSON-encoded BLOB data
  (arrays of integers) back to `Uint8List`, fixing cover image reads on web.
- Added corresponding `import 'dart:typed_data'`.

## 0.5.3

- Added refreshToken() method to SqliteWrapperGRPC for refreshing the auth token on the server, enabling long-lived sessions without re-authentication. 

## 0.5.2

- Fix per concurrent modification of `streams` in `SqliteWrapperGRPC.watch()` when multiple watches are active, preventing `ConcurrentModificationError` on stream updates.

## 0.5.1

- `SqliteWrapperGRPC.watch()` now automatically reconnects the server-streaming `Watch` RPC on connection close or error, with retry delays (1s on done, 2s on error), enabling resilient long-lived subscriptions.
- Fixed changelog ordering for historical entries.

## 0.5.0

- Added `Watch` server-streaming RPC in proto, with `WatchRequest`/`WatchResponse` messages — remote clients can now subscribe to real-time push updates triggered by any client's mutations.
- Added `tables` field to `SqlQueryRequest` for server-side table tracking.
- `SqliteWrapperGRPC.watch()` now uses the server-streaming `Watch` RPC instead of a local stream, enabling cross-client reactive updates.
- Added `clientOverride` setter in `SqliteWrapperGRPC` to support dependency injection in tests.
- `SqliteWrapperGRPC.execute()` now guards `updateStreams()` with `streams.isNotEmpty` to avoid unnecessary remote calls when no watches are active.
- Regenerated gRPC Dart stubs from updated proto.
- Updated documentation for the gRPC watch feature.

## 0.4.0

- **Breaking**: `closeDB()` changed to `Future<void>`. Callers must now `await closeDB()`.
- **Breaking**: `execute()` now returns `Future<dynamic>` (non-nullable) instead of `Future<dynamic>?`.
- **Breaking**: `getDatabase()` now returns `DatabaseCore?` instead of `dynamic`.
- **Breaking**: `DatabaseCore` promoted to real async interface with unified `execute`/`select`/`close`.
- **Breaking**: Removed `SqliteWrapperInterface` (was incomplete and unused).
- Added `transaction()` method wrapping `BEGIN`/`COMMIT`/`ROLLBACK`.
- Replaced singleton pattern with `inject_x` DI. `SQLiteWrapper` is deprecated.
- Instance state (`streams`, `databases`) is now per-instance instead of static.
- Column names in `update`/`delete`/`save` keys are now sanitized against SQL injection.
- `fixBoolParams` no longer mutates the input list.
- `fromMap` errors in `query()` now propagate instead of being silently swallowed.
- `updateStreams(null)` now refreshes all streams (used by `transaction`).
- `closeDB()` now removes stale streams for the closed database.
- gRPC: `closeDB()` now cleans up local state and shuts down the channel.
- gRPC: `SqliteWrapperGRPC()` default constructor removed — use `withHostAndPort`.
- Web: `:memory:` path no longer throws `UnimplementedError`.
- Source cleanup: removed `library sqlite_wrapper;` declarations.
- Removed redundant `getVersion`/`setVersion` overrides from platform implementations.
- Documentation updated for new DI patterns and API changes.

## 0.3.7-beta

- Refreshed GRPC generated code

## 0.3.6-beta

- Updated libraries version

## 0.3.5-beta

- fixed null error when dbName is missing and check if should useRPC

## 0.3.4-beta

- fixed problem with vacuum not executed

## 0.3.3-beta

- added userid in ValidateTokenResponse response

## 0.3.2-beta

- moved useRPC in openDB

## 0.3.1-beta

- renamed grpc class and file

## 0.3.0-beta

- added pRPG support

## 0.2.3

- created automation for publishing to github

## 0.2.2

- code reorganization and introduction of factory method getInstance

## 0.2.1

- exported isRunningOnWeb from platform

## 0.2.0

- bumped sqflite_common_ffi_web to latest version

## 0.2.0-dev-1

- added support for flutter web
- new lint rules
- added CI pipeline
- review of class structures

## 0.1.3

- bug fix for update and delete not working with tables having multiple primary keys

## 0.1.2

- Fixed some dependencies,lint problems and compiled with latest Flutter version
- Updated sqlite version dependency and sdk constraint

## 0.1.1

- the method updateStreams is now public to be able to force externally a refresh of one or more data streams

## 0.1.0

- created a parent class SQLiteWrapperCore that can be instantiated/subclassed and used instead of the Singleton implementation

## 0.0.9

- create the parent folders of the DB file if they are missing

## 0.0.8

- fixed a warning

## 0.0.7

- dbName param can now be null instead of having a default value set in every method call

## 0.0.6

- Added method save to perform an upsert

## 0.0.5

- Added assert to throw an error when the database has not been opened yet and you're trying to use it

## 0.0.4

- Fixed the version call to use the "user_version" instead of the "schema_version"
- Added onCreate and onUpgrade callback to simplify migrations
- Added support for opening multiple databases
- Now the openDB method returns some information about the database

## 0.0.3

- Autoremove the stream from the streams array when the subscription is cancelled

## 0.0.2

- Removed dependency from Flutter for tests
- Tested under Windows (both tests and examples)

## 0.0.1

- First release of the library in a complete (?) state.
- Tested under MacOs, iOS, Android
