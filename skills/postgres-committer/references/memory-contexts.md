# Memory Contexts

Postgres uses memory contexts to manage memory. The memory context documentation
is located in `src/backend/utils/mmgr/README`. Memory needs to be allocated and
freed in the correct context.

## Context Hierarchy

Contexts form a tree. Destroying a parent destroys all its children. Key
top-level contexts to know:

- `TopMemoryContext` — lives for the entire backend; almost nothing should
  allocate here directly.
- `CacheMemoryContext` — for long-lived cache entries (relcache, catcache).
- `TopTransactionContext` — reset at end of the top-level transaction.
- `CurTransactionContext` — reset at end of the current (sub)transaction.
- `MessageContext` — reset after each client message.
- `PortalContext` — tied to the active portal's lifetime.

When creating a new context, parent it to the context whose lifetime matches
the data's intended lifespan. Parenting to `TopMemoryContext` when
`TopTransactionContext` would suffice is a common source of leaks.

## Switching Contexts

Always save and restore the previous context:

```c
oldcxt = MemoryContextSwitchTo(mycxt);
result = palloc(size);
MemoryContextSwitchTo(oldcxt);
```

## Common Mistakes

### Returning data allocated in a short-lived context

```c
/* BAD: caller gets a dangling pointer after the context resets */
oldcxt = MemoryContextSwitchTo(econtext->ecxt_per_tuple_memory);
result = palloc(size);
MemoryContextSwitchTo(oldcxt);
return result;
```

Fix: switch to the caller's context (or a longer-lived one) before allocating
the return value.

### Leaking in a long-lived context inside a loop

```c
/* BAD: unbounded growth in CacheMemoryContext */
for (i = 0; i < n; i++)
{
    oldcxt = MemoryContextSwitchTo(CacheMemoryContext);
    tmp = palloc(size);
    MemoryContextSwitchTo(oldcxt);
}
```

Fix: allocate in a temporary context and `MemoryContextReset()` each iteration,
or `pfree()` when done.

### Early return without restoring context

```c
/* BAD: leaves CurrentMemoryContext wrong for the caller */
oldcxt = MemoryContextSwitchTo(mycxt);
if (error_condition)
    return NULL;
MemoryContextSwitchTo(oldcxt);
```

Fix: restore the context before every return path.
