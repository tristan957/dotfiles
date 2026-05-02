# Formatting

Postgres formatting is unique. It mixes various styles, but best practices
indicate that code should look like the surrounding code. Match variable name
styling, indentation, and other formatting choices of the existing code.

## C Code

- Tab indentation (4-wide tab stops). Never spaces for indentation.
- `pgindent` (using `pg_bsd_indent`) is the canonical formatter and should be
  run on every commit. GNU indent is not acceptable.
- New typedefs must be added to `src/tools/pgindent/typedefs.list` or
  `pgindent` will produce odd spacing.
- Naming: `lowercase_with_underscores` for functions and variables, `CamelCase`
  for typedefs and struct tags.
- File header comment uses the dashed-box style:

```c
/*-------------------------------------------------------------------------
 *
 * filename.c
 *    Brief description
 *
 *-------------------------------------------------------------------------
 */
```

- To protect manually formatted comment blocks from `pgindent` reflow, use:

```c
/*----------
 * This block will not be touched by pgindent.
 *----------
 */
```

## Perl Code

- Tab indentation (4-wide).
- Formatted with `perltidy` (version 20230309 specifically). The config is in
  `src/tools/pgindent/perltidyrc`.

## SGML Documentation

- Space indentation (1-space indent) for files in `doc/src/sgml`.

## What to Check During Review

- New code matches the style of the surrounding file.
- No space-based indentation in C or Perl files.
- No trailing whitespace.
- Files end with a newline.
