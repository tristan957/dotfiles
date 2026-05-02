# GUC Parameters

GUC (Grand Unified Configuration) parameters are Postgres's configuration
system. Parameters are defined in
`src/backend/utils/misc/guc_parameters.dat`. See
`src/backend/utils/misc/README` for design notes.

## Adding a GUC

1. Declare a global variable (`bool`, `int`, `double`, or `char*`).
2. Add a record to `guc_parameters.dat` in alphabetical order.
3. Add it to `postgresql.conf.sample` if appropriate.
4. Document it in `doc/src/sgml/config.sgml`.
5. If it's a `GUC_LIST_QUOTE` option, add it to
   `variable_is_guc_list_quote()` in `src/bin/pg_dump/dumputils.c`.

## Context Levels

The context controls when a GUC can be changed:

- `PGC_INTERNAL` — set at compile time only; cannot be changed at runtime.
- `PGC_POSTMASTER` — requires a server restart.
- `PGC_SIGHUP` — can be changed by reloading configuration (no restart).
- `PGC_SU_BACKEND` — set at connection start by superusers.
- `PGC_BACKEND` — set at connection start by any user.
- `PGC_SUSET` — changeable at runtime by superusers only.
- `PGC_USERSET` — changeable at runtime by any user.

Choose the most restrictive context that is practical. A GUC that affects
shared state should not be `PGC_USERSET`.

## Extension GUCs

Extensions register GUCs via `DefineCustom*Variable()` rather than
`guc_parameters.dat`. Extension GUC names must be prefixed with the extension
name (e.g., `pg_stat_statements.max`).

## What to Check During Review

- Context level is appropriate for the parameter's impact.
- Default value is sensible and documented.
- Bounds are set for numeric parameters.
- Entry added to `config.sgml` and `postgresql.conf.sample` where appropriate.
- Naming follows existing conventions (`lowercase_with_underscores`).
