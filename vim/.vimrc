" http://vimdoc.sourceforge.net/htmldoc/options.html

command ApplyGitEdge set cc=72 | highlight ColorColumn ctermbg=Red " show red bar at line 72

filetype plugin indent on " allow Vim to recognize the file type and use language-specific indentation

set autoindent " new lines inherit the indentation of previous lines
set autoread " relaod files changed outside of Vim
set background=dark " use dark theme
set backspace=indent,eol,start " influences the working of <BS>, <Del>, CTRL-W and CTRL-U in insert mode
set confirm " display confirmation dialog when closing unsaved file
set cursorline " highlight the current line
set encoding=UTF-8
set exrc " load .exrc file in current directory
set hlsearch " highlight matches
set incsearch " search as characters are entered
set laststatus=2 " always show the status bar
set lazyredraw " redraw only when we need to
set linebreak " wrap long lines at a character in 'breakat' rather than at the last character that fits on the screen
set number " show line numbers
set ruler " show the line and column number of the cursor position, separated by a comma
set noexpandtab " use tabs instead of spaces
set secure " no autocmd, shell, or write commands can be run in .exrc files
set shiftwidth=4 " number of spaces to use for each step of (auto)indent
set showbreak=++++  " what to show when line breaks
set showcmd " show the last run command
set showmatch " highlight matching brackets
set smartcase " automatically switch search to case-sensitive when search query contains an uppercase letter
set smartindent " smart autoindenting when starting a new line
set smarttab " a <Tab> in front of a line inserts blanks according to 'shiftwidth'.  'tabstop' or 'softtabstop' is used in other places
set softtabstop=4 " how many spaces a tab is when editing
set tabstop=4 " how many spaces a tab is when viewing
set termguicolors
set textwidth=100 " maximum width of text that is being inserted
set undolevels=1000 " maximum number of changes that can be undone
set wildmenu " visual autocomplete for command menu

syntax enable " enable syntax highlighting

" plug.vim initialization
if has('nvim') && empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
elseif empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'valloric/youcompleteme', { 'do': './install.py --java-completer --clangd-completer --clang-completer', 'for': ['java', 'c', 'cpp', 'python', 'typescript', 'javascript'] }
Plug 'scrooloose/syntastic'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
Plug 'easymotion/vim-easymotion'
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
Plug 'editorconfig/editorconfig-vim'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'scrooloose/nerdcommenter'
Plug 'morhetz/gruvbox'
Plug 'lifepillar/vim-solarized8'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

call plug#end()

colorscheme gruvbox

let g:syntastic_java_checkers = []
let g:airline_theme='gruvbox.vim'
let g:gruvbox_contrast_dark='hard'
let g:airline_powerline_fonts=0
let g:airline_theme='gruvbox'
let NERDTreeShowHidden=1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1

" shortcuts
map <C-b> :NERDTreeFocus<CR> " focus NERD Tree
map <C-t> :NERDTreeToggle<CR> " toggle NERD Tree
map <C-r> :NERDTreeRefreshRoot<CR> " refresh NERD Tree
nnoremap <C-Left> :tabprevious<CR> " previous tab
nnoremap <C-Right> :tabnext<CR> " next tab
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR> " move current tab left
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR> " move current tab right
nmap <silent> <A-Up> :wincmd k<CR> " move up a window
nmap <silent> <A-Down> :wincmd j<CR> " move down a window
nmap <silent> <A-Left> :wincmd h<CR> " move left a window
nmap <silent> <A-Right> :wincmd l<CR> " move right a window

" NERDTree show when directory opened
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
