" http://vimdoc.sourceforge.net/htmldoc/options.html

""""""""
" Plug
""""""""

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

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
if has('nvim-0.4.3') || has('patch8.0')
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }
endif
if executable('go') && (has('nvim-0.4.0') || has('patch8.0.1453'))
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
endif
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'gruvbox-community/gruvbox'
Plug 'lifepillar/vim-solarized8'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

syntax enable " enable syntax highlighting
let mapleader=" "

"""""""""""""
" Shortcuts
"""""""""""""

nnoremap <SPACE> <Nop>
map <leader>gs :Gstatus<CR>
nmap <leader>rw <Plug>(coc-rename) " rename word
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR> project-wide rename word
nnoremap <C-k> :<C-u>move-2<CR>== " move line up
nnoremap <C-j> :<C-u>move+<CR>== " move line down
nnoremap <leader>ogf :GFiles<CR>
nnoremap <leader>of :Files<CR>
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR> " move current tab left
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR> " move current tab right

""""""""""""
" Settings
""""""""""""
set autoindent " new lines inherit the indentation of previous lines
set autoread " relaod files changed outside of Vim
set backspace=indent,eol,start " influences the working of <BS>, <Del>, CTRL-W and CTRL-U in insert mode
set cmdheight=2 " give more space for displaying messages
set colorcolumn=80 "colorcolumn at 80
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
set noshowmode " don't show the mode since we are already using the statusbar
set nowrap " do not wrap
set nowritebackup " some language servers have issues with backup files, see coc.nvim#649
set noswapfile
set relativenumber " show relative line numbering
set secure " no autocmd, shell, or write commands can be run in .exrc files
set signcolumn=yes " always show the signcolumn
set shiftwidth=4 " number of spaces to use for each step of (auto)indent
set shortmess+=c " don't pass messages to |ins-completion-menu|
set showbreak=++++  " what to show when line breaks
" set showcmd " show the last run command
set showmatch " highlight matching brackets
set smartcase " automatically switch search to case-sensitive when search query contains an uppercase letter
set smartindent " smart autoindenting when starting a new line
set smarttab " a <Tab> in front of a line inserts blanks according to 'shiftwidth'.  'tabstop' or 'softtabstop' is used in other places
set softtabstop=0 " how many spaces a tab is when editing
set tabstop=4 " how many spaces a tab is when viewing
set termguicolors
set textwidth=100 " maximum width of text that is being inserted
set undodir=~/.cache/vim/undodir " remember to create directory
set undofile
set updatetime=300
set wildmenu " visual autocomplete for command menu

let g:netrw_banner=0
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitstatus', 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitstatus': 'FugitiveStatusLine',
  \   'cocstatus': 'coc#status',
  \   'currentfunction': 'CocCurrentFunction'
  \ },
\ }

let g:gruvbox_contrast_dark='hard'
let g:gruvbox_invert_selection='0'
colorscheme gruvbox
set background=dark

highlight ColorColumn ctermbg=237 guibg=#3C3836

"""""""""""""""""""""""""""""""
" File Type Specific Settings
"""""""""""""""""""""""""""""""

filetype on " allow Vim to recognize the file type

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

autocmd BufWritePre * :call TrimWhitespace()

"""""""""""""""""""
" Custom Commands
"""""""""""""""""""

""""""""""""
" coc.nvim
""""""""""""

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
