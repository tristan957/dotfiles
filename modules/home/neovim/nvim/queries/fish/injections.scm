; extends

; Inject printf format string highlighting for printf command
;
; printf '%s' 'value'
((command
    name: (word) @cmd .
    argument: [
      (single_quote_string)
      (double_quote_string)
    ] @injection.content)
  (#eq? @cmd "printf")
  (#set! injection.language "printf")
  (#offset! @injection.content 0 1 0 -1))

; Highlight Go templates in kubectl -o/--output go-template=<template>
;
; kubectl ... --output go-template='{...}'
((command
    name: (word) @cmd
    argument: (word) @flag
    argument: (concatenation
      (word) @format
      [
        (single_quote_string)
        (double_quote_string)
      ] @injection.content))
  (#eq? @cmd "kubectl")
  (#any-of? @flag "-o" "--output")
  (#eq? @format "go-template=")
  (#set! injection.language "gotmpl")
  (#offset! @injection.content 0 1 0 -1))

; Highlight awk programs when awk is the command
;
; awk '...'
((command
    name: (word) @cmd
    argument: [
      (single_quote_string)
      (double_quote_string)
    ] @injection.content)
  (#any-of? @cmd "awk" "gawk")
  (#set! injection.language "awk")
  (#offset! @injection.content 0 1 0 -1))
