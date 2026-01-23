; extends

; Inject PromQL into expr named arguments only in newTarget function calls for
; universe
((functioncall
  (fieldaccess
    last: (id) @_func)
  (args
    (named_argument
      (id) @_name
      (string
        (string_content) @injection.content))))
  (#eq? @_func "newTarget")
  (#eq? @_name "expr")
  (#set! injection.language "promql"))

; Inject SQL into rawSql named arguments only in newTarget function calls for
; universe
((functioncall
  (fieldaccess
    last: (id) @_func)
  (args
    (named_argument
      (id) @_name
      (string
        (string_content) @injection.content))))
  (#eq? @_func "newTarget")
  (#eq? @_name "rawSql")
  (#set! injection.language "sql"))
