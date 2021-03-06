" http://vimdoc.sourceforge.net/htmldoc/options.html

""""""""
" Plug
""""""""

" plug.vim initialization
if has('nvim') && empty(glob(stdpath('data') . '/site/autoload/plug.vim'))
  exe 'silent !curl -fLo ' . stdpath('data') . '/nvim/site/autoload/plug.vim --create-dirs'
    \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
elseif empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
if executable('go') && (has('nvim-0.4.0') || (has('patch8.0.1453') && !has('nvim')))
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
endif
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'gruvbox-community/gruvbox'
Plug 'lifepillar/vim-solarized8'
Plug 'itchyny/lightline.vim'
if has('nvim-0.5.0')
  Plug 'ThePrimeagen/git-worktree.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
else
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
endif

call plug#end()

syntax enable " enable syntax highlighting
let mapleader=" "

"""""""""""""
" Shortcuts
"""""""""""""

nnoremap <leader>gs :Gstatus<CR>
nnoremap <SPACE> <Nop>
nnoremap <leader>ogf :GFiles<CR>
nnoremap <leader>of :Files<CR>
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR> " move current tab left
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR> " move current tab right
vnoremap J :m '<+1<CR>gv=gv " move line up
vnoremap K :m '<-2<CR>gv=gv " move line down

""""""""""""
" Settings
""""""""""""
set autoindent " new lines inherit the indentation of previous lines
set autoread " relaod files changed outside of Vim
set backspace=indent,eol,start " influences the working of <BS>, <Del>, CTRL-W and CTRL-U in insert mode
set cmdheight=2 " give more space for displaying messages
set colorcolumn=80 " colorcolumn at 80
set completeopt=menuone,noinsert,noselect
set confirm " display confirmation dialog when closing unsaved file
set cursorline " highlight the current line
set encoding=UTF-8
set hidden " TextEdit might fail if hidden is not set
set hlsearch " highlight matches
set incsearch " search as characters are entered
set laststatus=2 " always show the status bar
set lazyredraw " redraw only when we need to
set linebreak " wrap long lines at a character in 'breakat' rather than at the last character that fits on the screen
set number " show line numbers
set ruler " show the line and column number of the cursor position, separated by a comma
set nobackup " some language servers have issues with backup files, see coc.nvim#649
set noerrorbells " no sounds please vim
set noexpandtab " use tabs instead of spaces
set nohlsearch " no highlight on search
set noshowmode " don't show the mode since we are already using the statusbar
set nowrap " do not wrap
set nowritebackup " some language servers have issues with backup files, see coc.nvim#649
set noswapfile
set nu " show current line number instead of 0
set relativenumber " show relative line numbering
set scrolloff=5 " start scrolling X lines from bottom or top
set secure " no autocmd, shell, or write commands can be run in .exrc files
set signcolumn=yes " always show the signcolumn
set shiftwidth=4 " number of spaces to use for each step of (auto)indent
set shortmess+=c " don't pass messages to |ins-completion-menu|
set showbreak=++++  " what to show when line breaks
" set showcmd " show the last run command
set showmatch " highlight matching brackets
set smartindent " smart autoindenting when starting a new line
set smarttab " a <Tab> in front of a line inserts blanks according to 'shiftwidth'.  'tabstop' or 'softtabstop' is used in other places
set softtabstop=4 " how many spaces a tab is when editing
set tabstop=4 " how many spaces a tab is when viewing
set termguicolors
set textwidth=100 " maximum width of text that is being inserted
set undodir=~/.cache/vim/undodir " remember to create directory
set undofile
set updatetime=50
set wildmenu " visual autocomplete for command menu

let g:netrw_banner=0
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

let g:gruvbox_contrast_dark='hard'
let g:gruvbox_invert_selection='0'
colorscheme gruvbox
set background=dark

highlight ColorColumn ctermbg=237 guibg=#3C3836

"""""""""""""""""""""""""""""""
" File Type Specific Settings
"""""""""""""""""""""""""""""""

filetype plugin on " allow Vim to recognize the file type

" C
autocmd FileType c setlocal noexpandtab tabstop=4 softtabstop=0
" C++
autocmd FileType cpp setlocal noexpandtab tabstop=4 softtabstop=0
" JSON
autocmd FileType json syntax match Comment +\/\/.\+$+
" Rust
autocmd FileType rust setlocal noexpandtab tabstop=4 softtabstop=0

""""""""""""""""
" Auto-behaviors
""""""""""""""""

" Toggle relativenumber in certain situations
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave " set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter " set norelativenumber
augroup END

" Trim whitespace upon writing buffer
fun! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

augroup tristan957
  autocmd!
  autocmd BufWritePre * :call TrimWhitespace()
augroup END

"""""""""""""""""""
" Custom Commands
"""""""""""""""""""

if has('nvim')
  lua require("tristan957")
endif
