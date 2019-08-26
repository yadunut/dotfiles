if &compatible
    set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/yadunandprem/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/yadunandprem/.cache/dein')
    call dein#begin('/Users/yadunandprem/.cache/dein')

    " Let dein manage dein
    " Required:
    call dein#add('/Users/yadunandprem/.cache/dein/repos/github.com/Shougo/dein.vim')


    call dein#add('Shougo/deoplete.nvim')               " Async autocomplete

    call dein#add('w0rp/ale')                           " Async Linting engine

    call dein#add('scrooloose/nerdtree')                " Treeview
    call dein#add('scrooloose/nerdcommenter')           " Commenting

    call dein#add('/usr/local/opt/fzf')                 " Fuzzy File Finding
    call dein#add('junegunn/fzf.vim')                   " Fuzzy File Finding

    call dein#add('vim-airline/vim-airline')            " Vim statusline
    call dein#add('vim-airline/vim-airline-themes')     " Statusline themes
    call dein#add('altercation/vim-colors-solarized')   " Vim Solarized Colorscheme
    call dein#add('edkolev/tmuxline.vim')               " Tmux statusline

    call dein#add('dart-lang/dart-vim-plugin')          " Dart syntax highlighting

    " call dein#add('fatih/vim-go')                       " Go Syntax and otehr functions

    " Required:
    call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

if dein#check_install()
    call dein#install()
endif

" End dein Scripts-------------------------

" Plugin Settings {{{
" Deoplete
let g:deoplete#enable_at_startup = 1

call deoplete#custom#option({
            \ 'auto_complete': v:true,
            \ 'auto_complete_delay': 1,
            \ 'camel_case': v:true,
            \ 'sources': {
            \ '_': ['ale','buffer', 'file'],
            \ 'dart': ['ale'],
            \ },
            \ })
call deoplete#custom#source('ale', 'rank', 1000)
call deoplete#custom#source('ale', 'mark', 'A')
call deoplete#custom#source('ale', 'min_pattern_length', 0)

" Ale
let g:ale_fixers = {
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \ 'cpp': ['clang-format'],
            \ 'c': ['clang-format'],
            \ 'ruby': ['rubocop'],
            \ 'sh': ['shfmt'],
            \ 'dart': ['dartfmt'],
            \ 'go': ['gofmt', 'goimports'],
            \ 'javascript': ['prettier'],
            \ 'css': ['prettier'],
            \ }
let g:ale_linters = {
            \ 'go': ['gopls'],
            \ 'dart': ['language_server'],
            \ }
            " \ 'ruby': ['solargraph'],
let g:ale_fix_on_save = 1
" let g:ale_sign_column_always = 1
" let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

" Airline
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1

" Tmuxline
let g:tmuxline_powerline_separators = 0

" NerdCommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1


" Keybinds----------------------
" Set leader key to space
let mapleader = "\<Space>"
" Better escape
imap jk <Esc>
" Map Semicolon to colon
nnoremap ; :

" Buffer control
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
nnoremap <C-b> :bdelete<CR>

" File operation
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>t :NERDTreeToggle<CR>
nnoremap <C-f> :Files<CR>

" Clipboard operations
nmap <Leader>yy "*yy
nmap <Leader>p "+p
vmap <Leader>y "+y

" Commenting


" Options-------------------
" Search options
set incsearch
set ignorecase
set smartcase

" Color options
colorscheme solarized
set background=dark

" Tab settings
set autoindent
set tabstop=8
set softtabstop=4
set expandtab " Use spaces instead of tabs 👿
set shiftwidth=4
set smarttab

set number
set relativenumber
set ruler
set hidden
set autowrite
set cmdheight=1

set noswapfile " Disable swaps

set grepprg=ag\ --nogroup\ --nocolor	" Use AG instead of grep

" Autocmds

" Close vim if only buffer is nerd tree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ALE Bindings

function ALELSPMappings()
  let l:lsp_found=0
  for l:linter in ale#linter#Get(&filetype) | if !empty(l:linter.lsp) | let l:lsp_found=1 | endif | endfor
  if (l:lsp_found)
    nnoremap <buffer> gd :ALEGoToDefinition<CR>
    nnoremap <buffer> <C-^> :ALEFindReferences<CR>
  endif
endfunction
autocmd BufRead,FileType * call ALELSPMappings()
