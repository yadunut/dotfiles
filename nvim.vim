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
let g:go_alternate_mode = "vsplit"
let g:go_fmt_command = "goimports"
let g:go_gocode_unimported_packages=1
" NerdTree
let NERDTreeHighlightCursorline = 0
" Tmuxline
let g:tmuxline_powerline_separators = 0
"vim-airline tabline
let g:airline#extensions#tabline#enabled = 1

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
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
" Save Line to clipboard
nmap <Leader>yy "*yy
" Paste from clipboard
nmap <Leader>p "+p
" Visual Mode save to clipboard
vmap <Leader>y "*y
" Visual mode paste from clipboard
vmap <Leader>p "*p

"Go Specific
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go set tabstop=4
autocmd FileType go set shiftwidth=4

