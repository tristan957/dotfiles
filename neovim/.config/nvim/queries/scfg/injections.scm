; extends

; Inject shell/bash syntax into token-cmd directive values for mjmap config
((directive
  (directive_name (word) @_name)
  (directive_params
    (word
      (dquote_word) @injection.content)))
 (#eq? @_name "token-cmd")
 (#filename-lua-match? ".*config/mjmap/config%.scfg$")
 (#set! injection.language "sh")
 (#offset! @injection.content 0 1 0 -1)) ; Exclude the quotes
