; extends

; SQL injection for rust-postgres client methods
(call_expression
  function: (field_expression
    field: (field_identifier) @_method)
  arguments: (arguments
    (string_literal
      (string_content) @injection.content))
  (#any-of? @_method "query" "query_one" "simple_query" "execute" "prepare")
  (#set! injection.language "sql"))

; SQL injection for sqlx function calls
(call_expression
  function: (scoped_identifier
    path: (identifier) @_crate
    name: (identifier) @_method)
  arguments: (arguments
    (string_literal
      (string_content) @injection.content))
  (#eq? @_crate "sqlx")
  (#any-of? @_method "query" "query_as" "query_scalar" "query_with" "execute")
  (#set! injection.language "sql"))

; SQL injection for sqlx macro calls
(macro_invocation
  macro: (scoped_identifier
    path: (identifier) @_crate
    name: (identifier) @_macro)
  (token_tree
    (string_literal
      (string_content) @injection.content))
  (#eq? @_crate "sqlx")
  (#any-of? @_macro "query!" "query_as!" "query_scalar!" "query_with!" "execute!")
  (#set! injection.language "sql"))
