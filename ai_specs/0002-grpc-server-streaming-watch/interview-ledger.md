---
type: Interview Ledger
parent: spec.md
---

## Records

### W1

Status: current

Question: Il proto `sqlite_wrapper_rpc.proto` è in un pacchetto pub.dev read-only o è modificabile?

Answer: Il pacchetto è mio, posso modificarlo.

Decision: I messaggi `WatchRequest`/`WatchResponse` e la RPC `Watch` vengono
aggiunti direttamente nel proto del pacchetto `sqlite_wrapper`, rigenerati con
`protos/refresh.sh`, e pubblicati come nuova versione (`0.5.0`). Nessun fork
o copia locale necessaria.

### W2

Status: current

Question: `WatchResponse` con un solo campo `string result` non permette al
client di distinguere un singolo valore da una lista. Due opzioni: (A) due
campi separati (`string json` + `bool singleResult`), (B) struttura fissa con
`repeated string rows`.

Answer: Scelta A — `string json` + `bool singleResult`.

Decision: `WatchResponse` ha `string json` e `bool singleResult`.
Il campo `singleResult` replica il valore della richiesta per comodità del
client.

### W3

Status: current

Question: Watch RPC deve essere autenticata o pubblica?

Answer: Autenticata come execute/select.

Decision: Watch NON è in `publicPaths`. Richiede JWT valido. L'interceptor
esistente copre automaticamente tutti i metodi di `SqliteWrapperService`
tramite path matching.

### W4

Status: current

Question: Connection pool deve essere passato via inject_x o globale statico?

Answer: Globale statico — non c'è stato per-utente.

Decision: `DatabasePool` è una classe con membri statici. Non registrata in
`inject_x`.

### W5

Status: current

Question: Come gestire `SQLITE_BUSY` in scritture concorrenti?

Answer: Retry baseline a 3 tentativi con backoff 50/100/150ms e timeout totale
300ms. L'implementazione va fatta dentro `DatabasePool` con fallimento
`GrpcError.unavailable('Database busy')`. Ottimizzazioni future dopo test
di carico.

Decision: Requisito R10 nel client spec e requisito corrispondente nel server
spec 0001. Baseline sufficiente per il lancio.
