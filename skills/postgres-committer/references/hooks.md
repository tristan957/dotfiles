# Hooks

Hooks are function pointers that allow extensions to intercept or augment core
behavior without modifying core code. They are declared as `PGDLLIMPORT`
global variables, typically with a `_hook` suffix.

## Common Hooks

- `planner_hook` — intercept or replace the planner.
- `ExecutorStart_hook`, `ExecutorRun_hook`, `ExecutorEnd_hook` — wrap executor
  stages.
- `post_parse_analyze_hook` — inspect or modify queries after parsing.
- `ProcessUtility_hook` — intercept utility statements.
- `emit_log_hook` — capture or redirect log output.
- `shmem_request_hook` — register shared memory during startup.

## Chaining Pattern

Extensions must save the previous hook value and call it, so multiple
extensions can coexist:

```c
static planner_hook_type prev_planner_hook = NULL;

void
_PG_init(void)
{
    prev_planner_hook = planner_hook;
    planner_hook = my_planner;
}

static PlannedStmt *
my_planner(Query *parse, const char *query_string, int cursorOptions,
           ParamListInfo boundParams)
{
    /* custom logic */
    if (prev_planner_hook)
        return prev_planner_hook(parse, query_string, cursorOptions,
                                 boundParams);
    return standard_planner(parse, query_string, cursorOptions, boundParams);
}
```

## What to Check During Review

- Previous hook value saved and called (chaining not broken).
- Hook installed in `_PG_init()` and not at an arbitrary point.
- Hook function matches the expected signature exactly.
- No assumptions about being the only extension using the hook.
