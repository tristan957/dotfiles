; extends

; Support for custom filename-lua-match? predicate
((predicate
  name: (identifier) @_name
  parameters: (parameters
    (string
      "\"" @string
      "\"" @string) @string.regexp))
  (#any-of? @_name "filename-lua-match"))
