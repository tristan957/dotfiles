; extends

; Highlight Python program strings when the interpreter is an argument such as
;
; exec python3 -c '...'
((command
    argument: (word) @cmd
    argument: (word) @flag
    argument: [
      (raw_string)
      (string)
    ] @injection.content)
  (#match? @cmd "^python(3)?$")
  (#eq? @flag "-c")
  (#set! injection.language "python")
  (#offset! @injection.content 0 1 0 -1))

; Highlight Python program strings when the interpreter is the command
;
; python3 -c '...'
((command
    name: (command_name (word) @cmd)
    argument: (word) @flag
    argument: [
      (raw_string)
      (string)
    ] @injection.content)
  (#match? @cmd "^python(3)?$")
  (#eq? @flag "-c")
  (#set! injection.language "python")
  (#offset! @injection.content 0 1 0 -1))

; Highlight psql SQL queries when psql is an argument such as
;
; exec psql -c '...'
((command
    argument: (word) @cmd
    argument: (word) @flag
    argument: [
      (raw_string)
      (string)
    ] @injection.content)
  (#eq? @cmd "psql")
  (#eq? @flag "-c")
  (#set! injection.language "sql")
  (#offset! @injection.content 0 1 0 -1))

; Highlight psql SQL queries when psql is the command
;
; psql -c '...'
((command
    name: (command_name (word) @cmd)
    argument: (word) @flag
    argument: [
      (raw_string)
      (string)
    ] @injection.content)
  (#eq? @cmd "psql")
  (#eq? @flag "-c")
  (#set! injection.language "sql")
  (#offset! @injection.content 0 1 0 -1))

; Highlight Go templates in kubectl -o/--output go-template=<template>
;
; kubectl ... --output go-template='{...}'
((command
    name: (command_name (word) @cmd)
    argument: (word) @flag
    argument: (concatenation
      (word) @format
      (raw_string) @injection.content))
  (#eq? @cmd "kubectl")
  (#any-of? @flag "-o" "--output")
  (#eq? @format "go-template=")
  (#set! injection.language "gotmpl")
  (#offset! @injection.content 0 1 0 -1))
