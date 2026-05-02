# Documentation

Postgres documentation is split into two parts: internal developer
documentation and user-facing documentation.

## Internal Developer Documentation

Internal developer documentation can be found in code comments, but also
`README` files in the source tree. Code comments should explain *why*, not
restate *what* the code does. Avoid overly verbose comments — if the code is
clear, a brief note on intent is sufficient.

- `README` files throughout the source tree (e.g., `src/backend/optimizer/README`,
  `src/backend/utils/mmgr/README`) provide design-level documentation for
  subsystems. Changes to a subsystem should update its README if the design
  changes.

## User-Facing Documentation

User-facing documentation is SGML (DocBook) located in `doc/src/sgml`.

- SQL command reference pages live in `doc/src/sgml/ref/` and follow a standard
  structure: synopsis, description, parameters, examples, compatibility, and
  see-also sections.
- Feature documentation (e.g., `logical-replication.sgml`, `mvcc.sgml`) covers
  concepts and usage.
- System catalog and view documentation is in `catalogs.sgml` and
  `system-views.sgml`.
- GUC parameters are documented in `config.sgml`.
- `contrib` module docs are individual `.sgml` files named after the module.

## What to Check During Review

- New SQL syntax or functions need reference page updates.
- New or changed GUCs need `config.sgml` updates.
- New catalog columns or views need catalog doc updates.
- Internal design changes should update the relevant `README`.
