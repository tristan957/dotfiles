# Concurrency

Postgres uses a multi-process architecture. Each backend and auxiliary process
is forked from the postmaster process. To achieve sharing data between
processes, Postgres uses shared memory. Shared memory needs to be properly
registered and may require some form of synchronization.

## Synchronization Primitives (lightest to heaviest)

1. Atomics (`pg_atomic_uint32`, `pg_atomic_uint64` in `port/atomics.h`) —
   lock-free operations on single values. Use for simple counters and flags
   where no broader critical section is needed.
1. SpinLocks — busy-wait locks that must be held for only a few instructions.
   No `CHECK_FOR_INTERRUPTS()` or blocking operations while held. Will abort
   after ~1 minute if not acquired.
1. LWLocks — lightweight locks supporting shared (read) and exclusive (write)
   modes. Used for protecting shared memory data structures. Can block, but
   should still be held briefly.
1. Heavyweight locks — SQL-level locks (relation locks, row locks, etc.) with
   full deadlock detection. These are the only locks that can be held for
   extended periods.

## Lock Ordering

When acquiring multiple locks, a consistent ordering must be followed to avoid
deadlocks. Violating lock ordering is a common source of hard-to-reproduce
bugs.

## What to Check During Review

- SpinLocks not held across anything that could block or take significant time.
- Locks released on all code paths, including error paths.
- Consistent lock acquisition ordering when multiple locks are involved.
- No TOCTOU races — checking a value then acting on it without holding the
  appropriate lock across both operations.
