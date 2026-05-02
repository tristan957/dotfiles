# Stability

Postgres takes backward compatibility seriously. Changes that break existing
users need strong justification and typically a deprecation period.

## On-Disk Format

Changing anything with regard to how files are stored on disk should be done
with extreme caution. Key areas:

- Heap and index page layout.
- WAL format.
- System catalog schema.
- `pg_control` format.

On-disk changes must either be backward-compatible or provide a migration path
through `pg_upgrade`. Catalog changes are especially sensitive since they affect
every database on upgrade.

## User-Facing Interfaces

- SQL syntax and semantics — changing behavior of existing SQL breaks
  applications.
- `libpq` wire protocol — clients depend on stable protocol behavior.
- System catalog views and `pg_*` functions — tools and ORMs query these
  directly.
- GUC parameters — renaming or changing defaults breaks existing
  `postgresql.conf` files.
- Error codes and messages — monitoring tools and applications often match on
  these.
