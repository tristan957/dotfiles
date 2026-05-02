# Security

Security is a very critical aspect of Postgres.

## C Programming Mistakes

- Buffer overflows — unchecked lengths passed to `memcpy`, `snprintf`
  truncation silently producing wrong results, `palloc` without validating size.
- Use-after-free — especially after `MemoryContextReset` or
  `MemoryContextDelete` (see `memory-contexts.md`).
- Integer overflow — arithmetic on user-supplied lengths before allocation.

## Privilege Escalation

- Missing permission checks — new SQL-callable functions must verify the caller
  has appropriate privileges (`superuser()`, `has_privs_of_role()`,
  `check_is_member_of_role()`).
- `SECURITY DEFINER` functions — these run with the definer's privileges. A
  manipulated `search_path` can cause them to call attacker-controlled objects.
- Predefined roles (`pg_read_all_data`, `pg_write_all_data`, etc.) — changes
  must not accidentally grant broader access than intended.

## Input Validation

- SQL-callable functions must validate all arguments before use. Null checks,
  range checks, and encoding validation are common gaps.
- Untrusted data used in internal queries (e.g., in `SPI_execute`) must be
  properly quoted or parameterized.

## Cancel Safety

Long-running loops should call `CHECK_FOR_INTERRUPTS()` to remain cancellable.
Missing this can cause a backend to become unresponsive to `pg_cancel_backend()`
or statement timeouts.

## Information Leakage

- Error messages should not expose data the user lacks permission to see (e.g.,
  column values in a table they can't read).
- Leaky operators in security barrier views and row-level security policies can
  expose filtered rows.
