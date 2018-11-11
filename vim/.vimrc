" http://vimdoc.sourceforge.net/htmldoc/options.html

command Git set cc=72 | highlight ColorColumn ctermbg=redraw		" show red bar at line 72

filetype indent on 													" language-specific indentation ~/.vim/indent

" Ctrl + T <arror>
map <C-t><up> :tabr<cr>												" go to first tab
map <C-t><down> :tabl<cr>											" go to last tab
map <C-t><left> :tabp<cr>											" move one tab left
map <C-t><right> :tabn<cr>											" move one tab right

set autoindent														" new lines inherit the indentation of previous lines
set backspace=indent,eol,start 										" influences the working of <BS>, <Del>, CTRL-W and CTRL-U in insert mode
set confirm															" display confirmation dialog when closing unsaved file
set cursorline														" highlight the current line
set hlsearch														" highlight matches
set incsearch														" search as characters are entered
set laststatus=2													" always show the status bar
set lazyredraw														" redraw only when we need to
set linebreak														" wrap long lines at a character in 'breakat' rather than at the last character that fits on the screen
set number															" show line numbers
set ruler															" show the line and column number of the cursor position, separated by a comma
set shiftwidth=4													" number of spaces to use for each step of (auto)indent
set showbreak=++++													" what to show when line breaks
set showcmd  														" show the last run command
set showmatch														" highlight matching brackets
set smartcase														" automatically switch search to case-sensitive when search query contains an uppercase letter
set smartindent														" smart autoindenting when starting a new line
set smarttab														" a <Tab> in front of a line inserts blanks according to 'shiftwidth'.  'tabstop' or 'softtabstop' is used in other places
set softtabstop=4 													" how many spaces a tab is when editing
set tabstop=4 														" how many spaces a tab is when viewing
set textwidth=100													" maximum width of text that is being inserted
set undolevels=1000													" maximum number of changes that can be undone
set wildmenu 														" visual autocomplete for command menu

syntax enable 														" enable syntax highlighting
