# Error Handling

Postgres uses `ereport` and `elog` for error reporting, and `PG_TRY`/`PG_CATCH`
for error recovery. Definitions are in `src/include/utils/elog.h`.

## Error Levels

- `DEBUG5`–`DEBUG1` — debugging messages, decreasing detail.
- `LOG` — server operational messages; sent to server log, not client.
- `INFO` — messages explicitly requested by the user (e.g., `VACUUM VERBOSE`).
- `NOTICE` — helpful messages about expected behavior (e.g., implicit sequence
  creation).
- `WARNING` — unexpected but non-fatal conditions.
- `ERROR` — aborts the current transaction and returns to a known state.
- `FATAL` — terminates the backend process.
- `PANIC` — takes down all backends; reserved for unrecoverable corruption.

## ereport vs elog

- `ereport` — the standard API. Supports `errcode()`, `errmsg()`,
  `errdetail()`, `errhint()`, and other auxiliary fields.
- `elog` — shorthand for internal messages where a SQLSTATE code and
  user-facing detail are not needed. Typically used with `DEBUG` or `LOG`.

## PG_TRY / PG_CATCH / PG_FINALLY

```c
PG_TRY();
{
    /* code that might throw ereport(ERROR) */
}
PG_CATCH();
{
    /* error recovery — must PG_RE_THROW() or abort (sub)transaction */
}
PG_END_TRY();
```

- `PG_FINALLY()` can replace `PG_CATCH()` when cleanup is the same for both
  success and error paths. Cannot use both in the same block.
- `ereport(FATAL)` is not caught by `PG_TRY` — it exits through `proc_exit()`
  directly.
- Keep error recovery simple to avoid nested errors.

## What to Check During Review

- Error level is appropriate — don't use `ERROR` for conditions that should be
  `WARNING` or `NOTICE`, and vice versa.
- `ereport` calls include a meaningful `errcode()` for user-facing errors.
- Error messages are clear and do not leak sensitive data (see `security.md`).
- Resources are cleaned up on error paths — use `PG_TRY`/`PG_FINALLY` or
  memory contexts (see `memory-contexts.md`) rather than manual cleanup.
- `PG_CATCH` blocks either re-throw or abort; silently swallowing errors leaves
  the system in an inconsistent state.
