let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitstatus', 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitstatus': 'FugitiveStatusLine',
  \ },
\ }
