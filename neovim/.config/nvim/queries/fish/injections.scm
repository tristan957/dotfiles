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
