---
type: Spec
title: gRPC Server-Streaming Watch
---

## Problem

The `sqlite_wrapper` package's `watch()` method creates reactive Dart `Stream`s
that emit new query results whenever the watched tables change. This mechanism
works within a single process: `execute()` calls `updateStreams()` locally,
which refreshes all active watch subscriptions. [GLOSSARY: StreamInfo, FromMap]

When using the remote gRPC mode via `SqliteWrapperGRPC`, `watch()` still creates
a **local** stream that is fed by the local `updateStreams()` call inside
`execute()`. This means:

1. **Client A** cannot see changes made by **Client B** (different process).
2. Updates are only pushed when the same client calls `execute()` — if another
   client modifies data, the local stream is never notified.
3. The proto file has a commented-out `Watch` RPC (`protos/sqlite_wrapper_rpc.proto:43`)
   and no `WatchRequest`/`WatchResponse` messages, leaving the feature unfinished.

The server project (`sqlite_wrapper_server`) has dead code (`static List<StreamInfo> streams`,
`lib/stream_info.dart`) that was started to bridge this gap but never completed.

## Proposed Outcome

A server-streaming gRPC `Watch` RPC that lets remote clients subscribe to SQL
queries and receive real-time push updates whenever any client modifies the
watched tables. The implementation spans two repositories:

1. **`sqlite_wrapper` package** (this repo): proto changes, regenerated gRPC stubs,
   `SqliteWrapperGRPC.watch()` overridden to use the server-streaming RPC.
2. **`sqlite_wrapper_server`**: See server spec `0001-grpc-watch-streaming` for
   `DatabasePool`, `Watch` RPC handler, and `execute`/`select`/`openDB`/`closeDB`
   refactored to use the pool. This spec only outlines server-side requirements;
   the server spec is the authoritative source for server implementation details.

## User Stories

1. As a remote client using `SqliteWrapperGRPC`, I want to call `watch()` and
   receive the initial query result plus subsequent updates pushed by the server,
   so I can build reactive UIs without polling. [GLOSSARY: SqliteWrapperGRPC]

2. As a remote client, I want my `watch()` subscription to receive updates
   triggered by SQL mutations from **any** client (not just my own), so that
   multi-user scenarios stay consistent in real time.

3. As the server operator, I want watch subscriptions to auto-clean when a
   client disconnects, so long-running connections do not leak memory.

## Requirements

### R1 — Proto: Watch RPC and Messages

**File:** `protos/sqlite_wrapper_rpc.proto`

Scommentare la RPC `Watch` e definire i messaggi:

```proto
message WatchRequest {
  string sql = 1;
  repeated google.protobuf.Any params = 2;
  string dbName = 3;
  repeated string tables = 4;
  bool singleResult = 5;
}

message WatchResponse {
  string json = 1;
  bool singleResult = 2;
}

message SqlQueryRequest {
  string sql = 1;
  repeated google.protobuf.Any params = 2;
  string dbName = 3;
  repeated string tables = 4;
}

service SqliteWrapperService {
  // ... existing RPCs unchanged ...

  rpc Watch(WatchRequest) returns (stream WatchResponse);
}
```

Il campo `tables` in `SqlQueryRequest` permette al server di notificare solo
gli stream che guardano le tabelle modificate, invece di aggiornarli tutti.

**Campo `WatchResponse.singleResult`:** indica al client se il `json` contiene
un singolo valore (`true`) o una lista (`false`). Necessario perché
`SQLiteWrapperBase.watch()` emette forme diverse in base al parametro
`singleResult` passato in `WatchRequest`.

### R2 — Generare i file Dart

**Script:** `protos/refresh.sh`

Eseguire `protoc` per rigenerare i file in `lib/generated/`:

```zsh
protoc --dart_out=grpc:lib/generated \
  -Iprotos \
  protos/sqlite_wrapper_rpc.proto \
  protos/google/protobuf/any.proto \
  protos/google/protobuf/wrappers.proto \
  protos/auth.proto
```

Commitare i file rigenerati:
- `lib/generated/sqlite_wrapper_rpc.pb.dart`
- `lib/generated/sqlite_wrapper_rpc.pbgrpc.dart`
- `lib/generated/sqlite_wrapper_rpc.pbenum.dart`
- `lib/generated/sqlite_wrapper_rpc.pbjson.dart`

### R3 — SqliteWrapperGRPC.watch() override

**File:** `lib/grpc/sqlite_wrapper_grpc.dart`

Override del metodo `watch()` ereditato da `SQLiteWrapperBase` per usare la
server-streaming RPC invece del meccanismo locale:

```dart
@override
Stream watch(
  String sql, {
  List<Object?> params = const [],
  FromMap? fromMap,
  bool singleResult = false,
  required List<String> tables,
  String? dbName,
}) {
  final responseStream = client.watch(WatchRequest(
    sql: sql,
    params: convertParamsToAny(params),
    dbName: dbName ?? defaultDBName,
    tables: tables,
    singleResult: singleResult,
  ));
  StreamSubscription? sub;
  final sc = StreamController(
    onCancel: () => sub?.cancel(),
  );
  sub = responseStream.listen(
    (response) {
      final decoded = jsonDecode(response.json);
      if (fromMap != null && !response.singleResult) {
        if (decoded is List) {
          sc.add(decoded.map((e) => fromMap(e as Map<String, dynamic>)).toList());
        } else if (decoded is Map<String, dynamic>) {
          sc.add(fromMap(decoded));
        } else {
          sc.add(decoded);
        }
      } else {
        sc.add(decoded);
      }
    },
    onDone: () => sc.close(),
    onError: (e) => sc.addError(e),
    cancelOnError: true,
  );
  return sc.stream;
}
```

Il metodo usa un `StreamController` manuale perché l'ereditato `watch()` in
`SQLiteWrapperBase` usa un `StreamController` internamente e l'override deve
restituire un `Stream`. L'`async*` non è utilizzabile perché il metodo deve
chiamare `super` concettualmente ma non può (la super versione creerebbe uno
stream locale che non vogliamo).

**Pulizia `SqliteWrapperGRPC.execute()`:** Dopo questo override, il metodo
`execute()` di `SqliteWrapperGRPC` eredita ancora da `SQLiteWrapperBase` il
blocco `finally { await updateStreams(tables); }` (riga 108-109). Poiché
l'override di `watch()` non popola più `streams`, quel blocco itera una lista
vuota. Rimuovere il blocco `finally` o sostituirlo con un controllo
`if (streams.isNotEmpty)` per evitare chiamate remote inutili via
`SqliteServiceClientWrapper.select()`.

### R4 — Esportare WatchRequest/WatchResponse

**File:** `lib/sqlite_wrapper.dart`

Verificare che i nuovi messaggi siano esportati. L'export esistente
`export 'generated/sqlite_wrapper_rpc.pb.dart'` copre già `WatchRequest` e
`WatchResponse` perché sono definiti nello stesso proto. Nessuna modifica
necessaria salvo la rigenerazione.

### R5 — Server: DatabasePool, Watch RPC, execute/select/shutdown, dead code

**Repo:** `sqlite_wrapper_server` — questi requisiti sono definiti in dettaglio
dallo **server spec `0001-grpc-watch-streaming`** (R4–R8). Questa sezione
riassume i capisaldi per coordinamento.

**R5a — DatabasePool (`lib/database_pool.dart`):**
Pool di connessioni SQLite con reference counting. Usa `dbName` come chiave
(mapping deterministico `dbName → dbPath` garantito dal server). Supporta
`get()`, `close()`, `subscribe()`, `unsubscribe()`, `closeAll()`.

**R5b — Watch RPC (`lib/sqlite_wrapper_server.dart`):**
Override del metodo `watch` che usa `DatabasePool.subscribe()` e decrementa
il reference count in `finally` (disconnessione automatica).

**Auth:** Watch NON è in `publicPaths`. Richiede JWT valido come
`execute`/`select`. L'interceptor esistente copre automaticamente tutti i
metodi di `SqliteWrapperService` tramite path matching.

**R5c — execute/select/openDB/closeDB refactored:**
Tutte le RPC che toccano il database usano `DatabasePool` invece del campo
`sqliteWrapper` singleton. `execute` passa `request.tables` a
`pool.execute(sql, tables: request.tables, ...)` per notificare solo gli
stream sulle tabelle modificate:

```dart
@override
Future<SqlQueryResponse> execute(ServiceCall call, SqlQueryRequest request) async {
  final String dbName = _getDBName(call: call, dbName: request.dbName);
  final wrapper = DatabasePool.get(dbName, _getDBPath(dbName));
  try {
    final res = await wrapper.execute(
      request.sql,
      tables: request.tables.toList(),
      params: _unpack(request.params.toList()),
    );
    return SqlQueryResponse(result: jsonEncode(res));
  } catch (e) {
    throw GrpcError.invalidArgument('SQL execution error: $e');
  }
}

@override
Future<SqlQueryResponse> select(ServiceCall call, SqlQueryRequest request) async {
  final String dbName = _getDBName(call: call, dbName: request.dbName);
  final wrapper = DatabasePool.get(dbName, _getDBPath(dbName));
  try {
    final db = wrapper.getDatabase();
    final res = db!.select(request.sql, _unpack(request.params.toList()));
    return SqlQueryResponse(result: jsonEncode(res));
  } catch (e) {
    throw GrpcError.invalidArgument('SQL query error: $e');
  }
}
```

**R5d — shutdown (`bin/main.dart`):**
`DatabasePool.closeAll()` nei gestori SIGINT/SIGTERM.

**R5e — Dead code:**
Rimuovere `static final List<StreamInfo> streams` da `SQLiteWrapperServerImpl`
ed eliminare `lib/stream_info.dart`.

### R10 — Retry su SQLITE_BUSY

L'implementazione di `DatabasePool` deve gestire potenziali conflitti di
scrittura. Inserire retry logic in `DatabasePool.get()` o in un wrapper:

```
tentativi massimi: 3
backoff: lineare 50ms, 100ms, 150ms
timeout totale: 300ms
fallimento: GrpcError.unavailable('Database busy')
```

## Technical Decisions

- **Proto nel pacchetto**: I messaggi `WatchRequest`/`WatchResponse` e la RPC
  `Watch` sono aggiunti al proto nel pacchetto `sqlite_wrapper`, non in un fork.
  Il pacchetto è di proprietà dell'autore e può essere pubblicato come `0.5.0`.

- **`WatchResponse.singleResult`** per disambiguare: il server emette JSON con
  forma diversa in base al parametro `singleResult` della richiesta. Il client
  usa `response.singleResult` per decidere se applicare `fromMap` alla lista
  o al singolo elemento.

- **`SqliteWrapperGRPC.watch()` non usa `async*`**: La gRPC response stream
  va sottoscritta con `listen()`. Un `StreamController` manuale è più
  espressivo e permette di mappare `fromMap` e gestire errori senza
  'await for' annidati.

- **`DatabasePool` statico, non DI**: Il pool è un singleton globale perché
  deve sopravvivere a richieste concorrenti e condividere connessioni tra
  RPC diverse. L'alternativa (passarlo via `inject_x`) aggiungerebbe
  complessità senza benefici dato che il pool non ha stato per-utente.

- **Watch richiede autenticazione**: La RPC `Watch` espone dati SQL in tempo
  reale. Deve essere protetta come `execute`/`select`. L'interceptor esistente
  copre automaticamente tutti i metodi di `SqliteWrapperService`.

- **`updateStreams()` chiamato da pool.execute()**: Il pool restituisce il
  `SQLiteWrapperBase` usato per la connessione. `execute()` su di esso chiama
  `updateStreams()` che notifica TUTTI gli stream registrati su QUEL wrapper.
  Poiché il pool mantiene un wrapper per `dbName`, tutti i Watch sullo stesso
  database vengono notificati.

## Testing Strategy

### Unit test — pacchetto `sqlite_wrapper`

- `SqliteWrapperGRPC.watch()`: mockare `client.watch()` per restituire un
  `Stream` controllato. Verificare che `fromMap` venga applicato, che
  `singleResult` sia propagato, che la disconnessione chiuda lo stream.

### Unit test — server

File: `sqlite_wrapper_server/test/services/database_pool_test.dart`

- `subscribe()` restituisce stream che emette risultato iniziale
- `execute()` dopo `subscribe()` triggera nuovo evento sul watch
- `unsubscribe()` rilascia risorse (watchCount → 0 → closeDB)
- Due subscribe sullo stesso db ricevono entrambi gli eventi
- `closeAll()` chiude tutte le connessioni

### Param type round-trip verification

Verificare che `convertParamsToAny` / `_unpack` gestiscano correttamente tutti
i tipi SQL rilevanti (null, int, double, String, bool, Blob) via `WatchRequest`
in un test di conversione esplicito. Aggiungere test in
`test/grpc/grpc_helper_test.dart` nel pacchetto `sqlite_wrapper`.

### Integration test

File: `sqlite_wrapper_server/test/integration/watch_test.dart` (dettaglio
completo nello server spec 0001 — qui solo schema):

```dart
test('Client B execute → Client A watch riceve update via gRPC', () async {
  final server = await startServer();
  final clientA = SqliteWrapperGRPC.withHostAndPort(host: 'localhost', port: 50051);
  final clientB = SqliteWrapperGRPC.withHostAndPort(host: 'localhost', port: 50051);
  await clientA.openDB(':memory:', dbName: 'test');
  await clientB.openDB(':memory:', dbName: 'test');
  await clientA.execute(
    "CREATE TABLE todos (id INTEGER PRIMARY KEY, title TEXT, done INT DEFAULT 0)",
    dbName: 'test',
  );

  final events = <List>[];
  final sub = clientA
    .watch("SELECT * FROM todos", tables: ["todos"], dbName: 'test')
    .listen((e) => events.add(e));

  // Attendere risultato iniziale tramite stream matcher
  await expectLater(
    events.stream,
    emits(isA<List>()),
  );

  // Client B inserisce
  await clientB.execute(
    "INSERT INTO todos (title) VALUES ('test')",
    dbName: 'test',
  );

  // Attendere aggiornamento pushato tramite stream matcher
  await expectLater(
    events.stream,
    emits((List list) => list.length == 1),
  );

  await sub.cancel();
  await server.shutdown();
});
```

## Out of Scope

- RPC `Watch` con `fromMap` serializzato via proto — non fattibile (callback).
  Il mapping viene applicato lato client.
- Watching su tabelle di database diversi in una singola richiesta — il
  parametro `tables` è già una lista, supportato dal `SQLiteWrapperBase`.
- Watch in modalità `useGRPC = true` su `SqliteWrapperGRPC` — uso circolare,
  non ha senso.

## Follow-Ups

- Pubblicare `sqlite_wrapper 0.5.0` con i nuovi messaggi proto e il fix in
  `SqliteWrapperGRPC.watch()`.
- Aggiornare `sqlite_wrapper_server` per dipendere da `sqlite_wrapper: ^0.5.0`.
- Aggiornare l'esempio Flutter (in `sqlite_wrapper_server/sqlite_wrapper_grpc_example/`)
  per sfruttare watch cross-client.
