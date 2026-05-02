# SQL-Callable C Functions

Postgres SQL-callable functions are written in C using the `PG_FUNCTION_ARGS`
calling convention. They receive arguments via `PG_GETARG_*` macros and return
results via `PG_RETURN_*` macros or the `Datum` type.

## Scalar Functions

Return a single value. Registered in `pg_proc.dat` with a concrete
`prorettype` and `proargtypes`.

```c
Datum
pg_stat_get_function_calls(PG_FUNCTION_ARGS)
{
    Oid         funcid = PG_GETARG_OID(0);
    PgStat_StatFuncEntry *funcentry;

    if ((funcentry = pgstat_fetch_stat_funcentry(funcid)) == NULL)
        PG_RETURN_NULL();
    PG_RETURN_INT64(funcentry->numcalls);
}
```

## Datum Conversions

Arguments and return values are passed as `Datum`. Common conversion macros:

- `PG_GETARG_INT32(n)` / `Int32GetDatum(x)` / `PG_RETURN_INT32(x)`
- `PG_GETARG_INT64(n)` / `Int64GetDatum(x)` / `PG_RETURN_INT64(x)`
- `PG_GETARG_OID(n)` / `ObjectIdGetDatum(x)` / `PG_RETURN_OID(x)`
- `PG_GETARG_BOOL(n)` / `BoolGetDatum(x)` / `PG_RETURN_BOOL(x)`
- `PG_GETARG_TEXT_PP(n)` / `CStringGetTextDatum(s)` / `PG_RETURN_TEXT_P(x)`
- `PG_GETARG_FLOAT8(n)` / `Float8GetDatum(x)` / `PG_RETURN_FLOAT8(x)`

Use `PG_ARGISNULL(n)` to check for NULL inputs. Use `PG_RETURN_NULL()` to
return NULL.

## Set-Returning Functions (SRFs)

Functions that return multiple rows. Two patterns exist:

### Materialized (Preferred)

Build all rows into a tuplestore in a single call. The executor reads from
the store afterward.

```c
Datum
my_srf(PG_FUNCTION_ARGS)
{
    ReturnSetInfo *rsinfo;

    InitMaterializedSRF(fcinfo, 0);
    rsinfo = (ReturnSetInfo *) fcinfo->resultinfo;

    for (...)
    {
        Datum   values[NUM_COLS] = {0};
        bool    nulls[NUM_COLS] = {0};

        values[0] = CStringGetTextDatum("example");
        values[1] = Int64GetDatum(42);

        tuplestore_putvalues(rsinfo->setResult, rsinfo->setDesc,
                             values, nulls);
    }

    return (Datum) 0;
}
```

Use this when the result set is bounded or can be computed in one pass. This
is the pattern used by nearly all modern SRFs.

### Value-Per-Call (Legacy)

The function is called repeatedly, returning one row per call. State is kept
in `FuncCallContext->user_fctx` across calls.

```c
if (SRF_IS_FIRSTCALL())
{
    funcctx = SRF_FIRSTCALL_INIT();
    /* allocate state in funcctx->multi_call_memory_ctx */
}
funcctx = SRF_PERCALL_SETUP();

if (have_more_rows)
    SRF_RETURN_NEXT(funcctx, result);
else
    SRF_RETURN_DONE(funcctx);
```

Use only when lazy evaluation is needed — e.g., the result depends on state
that may change between calls.

## Catalog Registration (pg_proc.dat)

Every SQL-callable function needs an entry in `src/include/catalog/pg_proc.dat`.

Scalar example:

```perl
{ oid => '2978',
  proname => 'pg_stat_get_function_calls', provolatile => 's',
  proparallel => 'r', prorettype => 'int8', proargtypes => 'oid',
  prosrc => 'pg_stat_get_function_calls' },
```

SRF example — requires `proretset => 't'`, `prorettype => 'record'`, and
output column declarations:

```perl
{ oid => '8683',
  proname => 'pg_stat_get_kind_info', prorows => '20', proretset => 't',
  provolatile => 'v', proparallel => 'r', prorettype => 'record',
  proargtypes => '', proallargtypes => '{text,int8,bool,int8}',
  proargmodes => '{o,o,o,o}',
  proargnames => '{name,count,builtin,shmem_size}',
  prosrc => 'pg_stat_get_kind_info' },
```

Key fields for SRFs:
- `proallargtypes` — types of all arguments (input + output)
- `proargmodes` — `o` for each output column
- `proargnames` — column names matching the output order
- `prorows` — estimated row count for the planner

## What to Check During Review

- Scalar functions validate arguments and handle NULLs before use.
- SRFs prefer materialized over value-per-call unless lazy evaluation is needed.
- Output column count in `pg_proc.dat` exactly matches the C values array size.
  A mismatch causes buffer overruns in `tuplestore_putvalues`.
- Column types in `proallargtypes` match the `Datum` conversions in C.
- Views wrapping an SRF select all declared output columns.
- Bounded loops do not need `CHECK_FOR_INTERRUPTS()`; long or unbounded
  loops do.
