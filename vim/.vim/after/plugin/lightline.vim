let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitstatus', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'colorscheme': 'one',
  \ 'component_function': {
  \   'gitstatus': 'FugitiveHead',
  \ },
\ }
