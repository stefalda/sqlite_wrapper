---
type: Interview Ledger
parent: spec.md
---

## Records

### L1

Status: current

Question: Quali aspetti della libreria vuoi prioritizzare? (Resilienza, Performance, Sicurezza, Manutenibilità)

Answer: Tutti i precedenti

Decision: All four areas (resilience, performance, security, maintainability) are in scope.

### L2

Status: current

Question: Le ottimizzazioni/fix devono essere solo refactor interno o possono includere modifiche all'API pubblica?

Answer: Disponibile anche a modifiche all'API pubblica se necessario o sensato.

Decision: Breaking changes are accepted when justified.

### L3

Status: current

Question: L'API attuale permette SQL injection nelle colonne. Opzioni: sanitize nomi, cambiare API, lasciare invariato.

Answer: Sanitizzare ma tendenzialmente le query arrivano da codice non da utente.

Decision: Column names must be sanitized (backtick quoting or regex `^[a-zA-Z_][a-zA-Z0-9_]*$`). API signature unchanged.

### L4

Status: current

Question: Lo stato statico condiviso (streams list, Databases map) causa race condition. Proposto: convertire in membri di istanza.

Answer: Sì. In più non sono più convinto dell'architettura singleton, userei inject_x.

Decision:
- `streams` and `Databases` move from `static` to instance members on `SQLiteWrapperBase`.
- Singleton `SQLiteWrapper` is deprecated (not removed).
- `inject_x` package is adopted for dependency injection.

### L5

Status: current

Question: Con inject_x, come vuoi che l'utente ottenga un'istanza? Registrazione manuale o automatica?

Recommended Answer: Registrazione manuale esplicita in `main()` via `InjectX.add<SQLiteWrapperBase>(...)`. Factory `getInstance()` diventa helper che fa `InjectX.add()` e restituisce l'istanza.

Answer: Ok.

Decision: Manual registration. `getInstance()` updated as a helper. `SQLiteWrapper` singleton deprecated.

### L6

Status: current

Question: closeDB() è void su SQLiteWrapperBase ma async su SqliteWrapperGRPC. Proposto: Future<void> closeDB().

Answer: Accettato.

Decision: `closeDB()` signature changes from `void` to `Future<void>`.

### L7

Status: current

Question: execute() restituisce Future<dynamic>? (nullable). Proposto: Future<dynamic> non nullable.

Answer: Accettato.

Decision: `execute()` return type changes from `Future<dynamic>?` to `Future<dynamic>`.

### L8

Status: current

Question: DatabaseCore è definito ma mai usato come constraint. Proposto: rimuoverlo o resuscitarlo come interfaccia reale.

Answer: Era nato come interfaccia unica per l'accesso al DB indipendentemente dalla piattaforma. Portare tutto ad async per risolvere.

Decision: `DatabaseCore` restored as a real abstract interface with all-async methods (`Future<void> execute`, `Future<List<Map>> select`, `void dispose`). Used as the type parameter in `Databases` and `_getDB()` instead of `dynamic`.

### L9

Status: current

Question: fixBoolParams muta la lista params passata dal chiamante. Proposto: non mutare più, creare nuova lista.

Answer: Ok.

Decision: `fixBoolParams` creates a new list instead of mutating the input.

### L10

Status: current

Question: La libreria non ha API per transazioni. Proposto: metodo `transaction(Future<void> Function() action, {String? dbName})`.

Answer: Ok, dobbiamo poi aggiornare la documentazione.

Decision:
- New `transaction()` method added.
- `BEGIN` / `COMMIT` / `ROLLBACK` managed internally.
- Streams updated only on successful `COMMIT`.
- Documentation updated.

### L11

Status: current

Question: Error handling in query() — fromMap errors vengono catturati e stampati con print(), ma il metodo continua. Proposto: rilanciare l'eccezione.

Answer: Accettato (via "Tutti" a L2-L7-L8-L9 bundle).

Decision: `fromMap` errors in `query()` rethrow instead of silently falling back to raw map.

### L12

Status: current

Question: Documentazione da aggiornare per API changes e nuovo pattern DI.

Answer: Ok.

Decision: README.md and example code updated for all API changes, InjectX integration, and new patterns.

### L13

Status: current

Question: singola istanza via DI o più istanze indipendenti?

Recommended Answer: Una singola istanza via DI (InjectX), dato che sync_client estende SQLiteWrapperCore già con istanze dirette.

Answer: Per l'utente meglio un'unica istanza, ma verifica sync_client.

Decision: Single instance via `InjectX.add<SQLiteWrapperBase>()`. `SQLiteWrapperBase` (not `SQLiteWrapperCore`) is the registered type. Multiple databases are still supported via the `dbName` parameter on the same instance.
