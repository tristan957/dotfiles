# Testing

Postgres has various forms of tests. Tests are not only in `src/test/` — they
also live in `contrib/` modules and `src/bin/` utilities.

## Regression Tests

Located in directories called `regress`. A test consists of a SQL file in
`sql/` and a matching expected output file in `expected/`. The test runner
executes the SQL and diffs the output against the expected file. When modifying
behavior, the expected file must be updated to match.

## TAP Tests

These are Perl tests located in directories called `t`. They use the
infrastructure in `src/test/perl`, primarily:

- `PostgreSQL::Test::Cluster` — spin up/stop/manage Postgres instances.
- `PostgreSQL::Test::Utils` — helper functions for common test operations.

TAP tests use `use strict` and `use warnings FATAL => 'all'`. Variables must
be declared with `my` before use, and redeclaring `my` on the same variable
in the same scope triggers a fatal warning. When adding code before an
existing `my $var` declaration, either place the new `my` first or reuse the
variable without redeclaring.

TAP tests are used for things that need a running server or multiple servers
(e.g., replication, recovery, pg_basebackup).

## Isolation Tests

For testing concurrency. Test files have a `.spec` extension and live in
`specs/` directories. A spec file defines:

- `setup` / `teardown` blocks for schema creation and cleanup.
- `session` blocks, each with named `step` commands.
- `permutation` lines to control the interleaving order.

The isolation test runner (`isolationtester`) executes steps across concurrent
sessions and compares output against expected files.

## Test Modules

`src/test/modules/` contains extensions used only for testing (e.g.,
`injection_points`, `delay_execution`). These are not installed in production.

## Running Tests

Tests are run via `meson test` from the build directory. Before running tests,
the build must be installed into `tmp_install` and an initdb template cache
must be created. These steps need to be re-run when the build changes.

```sh
# Install and prepare the test environment
DESTDIR=tmp_install ninja install
meson test postgresql:initdb_cache
```

Test modules (`src/test/modules/`) are installed separately. Re-run this after
modifying test module code:

```sh
DESTDIR=tmp_install ninja install-test-files
```

Running tests:

```sh
meson test postgresql:regress/regress                  # main regression suite
meson test postgresql:test_custom_stats/001_custom_stats  # a specific TAP test
meson test --list                                      # list all available tests
```

Use `--no-rebuild` to skip recompilation if you know the build is current.

## What to Check During Review

- Behavioral changes should have regression or TAP tests.
- Concurrency-related changes need isolation tests.
- Expected output files must be updated when test output changes.
- Tests should not depend on timing or platform-specific behavior.
- New test files must be registered in the appropriate `meson.build`.
