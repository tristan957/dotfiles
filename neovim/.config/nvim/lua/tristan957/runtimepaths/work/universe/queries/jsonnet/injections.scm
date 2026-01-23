; extends

; Inject PromQL into expr named arguments only in newTarget function calls
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

; Inject SQL into rawSql named arguments only in newTarget function calls
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

; Inject PromQL into queryMetric named arguments only in
; queryTemplateWithCachingDef function calls
((functioncall
  (fieldaccess
    last: (id) @_func)
  (args
    (named_argument
      (id) @_name
      (string
        (string_content) @injection.content))))
  (#eq? @_func "queryTemplateWithCachingDef")
  (#eq? @_name "queryMetric")
  (#set! injection.language "promql"))

; Inject regex into regex named arguments only in queryTemplateWithCachingDef
; function calls
((functioncall
  (fieldaccess
    last: (id) @_func)
  (args
    (named_argument
      (id) @_name
      (string
        (string_content) @injection.content))))
  (#eq? @_func "queryTemplateWithCachingDef")
  (#eq? @_name "regex")
  (#set! injection.language "regex"))
