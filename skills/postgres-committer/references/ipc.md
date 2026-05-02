# Interprocess Communication

Postgres uses a multi-process architecture where backends and auxiliary
processes need to communicate. There are several IPC mechanisms.

## Latches

Latches (`SetLatch`, `WaitLatch`, `ResetLatch`) are used to wake a process
when something needs attention. A shared latch resides in shared memory and
can be set by any process; a local latch can only be set by a signal handler
within the same process. Latches must be reset before re-checking the condition
to avoid missed wakeups.

## Shared Memory

Processes share data through shared memory. Extensions register shared memory
using `ShmemCallbacks` and `RegisterShmemCallbacks()` in `_PG_init()`:

```c
static MySharedState *my_state;
static HTAB *my_hash;

static void
my_shmem_request(void *arg)
{
    ShmemRequestStruct(.name = "my_extension",
                       .size = sizeof(MySharedState),
                       .ptr = (void **) &my_state);
}

static void
my_shmem_init(void *arg)
{
    int tranche_id = LWLockNewTrancheId("my_extension");
    LWLockInitialize(&my_state->lock.lock, tranche_id);
}

static const ShmemCallbacks my_shmem_callbacks = {
    .request_fn = my_shmem_request,
    .init_fn = my_shmem_init,
};

void
_PG_init(void)
{
    RegisterShmemCallbacks(&my_shmem_callbacks);
}
```

Core code registers shared memory in `ipci.c` instead. Shared memory structures
typically need synchronization (see `concurrency.md`).

## Signals

`procsignal` provides a mechanism for sending typed signals between backends
(e.g., requesting a barrier, triggering a catchup interrupt). Direct use of
OS signals should be avoided in favor of this abstraction.

## Shared Invalidation Messages

The sinval (shared invalidation) system lets backends broadcast cache
invalidation events. When a backend modifies a catalog entry, it sends an
invalidation message so other backends know to refresh their caches.
