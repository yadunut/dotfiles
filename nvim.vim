" Vim Configuration
"
" show line number
set number
" line number relative to current cursor position
set relativenumber
" use spaces
set expandtab
" width of tab
set tabstop=4
" how many spaces to go when >> or <<
set shiftwidth=4
" allows you to change buffer without saving
set hidden

" Plugins
"
" dein config
if &compatible
  set nocompatible
endif

set runtimepath+=/Users/yadunandprem/.config/nvim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('/Users/yadunandprem/.config/nvim/dein')
  call dein#begin('/Users/yadunandprem/.config/nvim/dein')

  " Let dein manage dein
  call dein#add('/Users/yadunandprem/.config/nvim/dein/repos/github.com/Shougo/dein.vim')
  " Treeview
  call dein#add('scrooloose/nerdtree')
  " Autocompletion
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('autozimu/LanguageClient-neovim', {'rev': 'next', 'build': 'bash install.sh'})
  " Golang autcompletion
  call dein#add('fatih/vim-go')
  call dein#add('zchee/deoplete-go', {'build': 'make'})
  " Easier navigation between tmux and vim panes
  call dein#add('christoomey/vim-tmux-navigator')
  " Vim powerline
  call dein#add('vim-airline/vim-airline')
  " Vim powerline Theme
  call dein#add('vim-airline/vim-airline-themes')
  " Tmuxline
  call dein#add('edkolev/tmuxline.vim')
  "Vim tmux integration
  call dein#add('benmills/vimux')
  " Fuzzy finder
  call dein#add('/usr/local/opt/fzf')
  call dein#add('junegunn/fzf.vim')
  " Vim Ruby
  call dein#add('vim-ruby/vim-ruby')
  " Vim Rails
  call dein#add('tpope/vim-rails')
  " Vim Slim 
  call dein#add('slim-template/vim-slim')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

" Plugin Config
"
" Enable Deoplete at startup
let g:deoplete#enable_at_startup = 1
" Go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_alternate_mode = "edit"
let g:go_fmt_command = "goimports"
let g:go_gocode_unimported_packages=1
" NerdTree
let NERDTreeHighlightCursorline = 0
" Tmuxline
let g:tmuxline_powerline_separators = 0
" vim-airline tabline
let g:airline#extensions#tabline#enabled = 1
" Language Client
let g:LanguageClient_serverCommands = {
    \ 'ruby': ['tcp://localhost:7658'],
    \ }
let g:LanguageClient_autoStop = 0

" Keybinds
"
" set leader key to space
let mapleader = "\<Space>"
" Map jk to escape
imap jk <Esc>
" Map semi-colon to colon
nnoremap ; :
" Go to next buffer
nnoremap <C-n> :bnext<CR>
" Go to previous buffer
nnoremap <C-b> :bprevious<CR>
" Close current buffer
nnoremap <C-v> :bdelete<CR>
" Save File
nnoremap <Leader>w :w<CR>
" Quit File
nnoremap <Leader>q :q<CR>
" Open NerdTree
nnoremap <Leader>t :NERDTreeToggle<CR>
" Vimux Config
let g:VimuxOrientation = "h"

" Useful functions
"
" Tab completion for deoplete
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
" Removes trailing whitepace on F5
nnoremap <silent> <F6> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
" Save Line to clipboard
nmap <Leader>yy "*yy
" Paste from clipboard
nmap <Leader>p "+p
" Visual Mode save to clipboard
vmap <Leader>y "*y
" Visual mode paste from clipboard
vmap <Leader>p "*p
nmap <C-p> :Files<CR>

" Go Specific
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go set tabstop=4
autocmd FileType go set shiftwidth=4
autocmd FileType go nmap <leader>u :w<CR><Plug>(go-test)

if exists('$TMUX')
    autocmd FileType go nmap <leader>r :w<CR>:VimuxRunCommand("clear; go run ".bufname("%"))<CR>
    autocmd FileType go nmap <leader>m :w<CR>:VimuxRunCommand("clear; make dev")<CR>
else
    autocmd FileType go nmap <leader>r :w<CR><Plug>(go-run)
endif

" Ruby specific
if exists('$TMUX')
    autocmd FileType ruby nmap <leader>r :w<CR>:VimuxRunCommand("clear; rake")<CR>
    autocmd FileType ruby nmap <leader>m :w<CR>:VimuxRunCommand("clear;rspec .")<CR>
endif

autocmd FileType ruby set expandtab
autocmd FileType ruby set shiftwidth=2
autocmd FileType ruby set softtabstop=2

" LanguageClient ruby specific
autocmd FileType ruby nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
autocmd FileType ruby nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
autocmd FileType ruby nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
