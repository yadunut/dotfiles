
"__   __        _                             _   ______
"\ \ / /       | |                           | |  | ___ \
" \ V /__ _  __| |_   _ _ __   __ _ _ __   __| |  | |_/ / __ ___ _ __ ___
"  \ // _` |/ _` | | | | '_ \ / _` | '_ \ / _` |  |  __/ '__/ _ \ '_ ` _ \
"  | | (_| | (_| | |_| | | | | (_| | | | | (_| |  | |  | | |  __/ | | | | |
"  \_/\__,_|\__,_|\__,_|_| |_|\__,_|_| |_|\__,_|  \_|  |_|  \___|_| |_| |_|

"--------------------------------------------------------------------------------
"------------------------Neovim Configuration-------------------------
"--------------------------------------------------------------------------------
"
"Sets line number and relative line number
set number
set relativenumber
"Changes tabs to spaces
set expandtab
set tabstop=2
set shiftwidth=2

set hidden


"--------------------------------------------------------------------------------
"------------------------------------Plugins-------------------------------------
"--------------------------------------------------------------------------------
if &compatible
  set nocompatible
endif

"Required:
set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim

"Required:
if dein#load_state('~/.config/nvim/dein')
  call dein#begin('~/.config/nvim/dein')

  "Let dein manage dein
  "Required:
  call dein#add('~/.config/nvim/dein/repos/github.com/Shougo/dein.vim')

  "Add or remove your plugins here:
  "Autocompletion
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/neco-syntax')
  "Golang autcompletion
  call dein#add('fatih/vim-go')
  call dein#add('zchee/deoplete-go', {'build': 'make'})
  "Easier navigation between tmux and vim panes
  call dein#add('christoomey/vim-tmux-navigator')
  "TreeView
  call dein#add('scrooloose/nerdtree')
  "Vim powerline
  call dein#add('vim-airline/vim-airline')
  "Vim powerline Theme
  call dein#add('vim-airline/vim-airline-themes')
  "Tmux powerline
  call dein#add('edkolev/tmuxline.vim')
  "Commenting
  call dein#add('scrooloose/nerdcommenter')
  "Snippets
  call dein#add('SirVer/ultisnips')
  "Org-mode
  call dein#add('jceb/vim-orgmode')
  "ruby
  "call dein#add('vim-ruby/vim-ruby')
  "call dein#add('fishbullet/deoplete-ruby')
  "tmux
  call dein#add('benmills/vimux')


  "Required:
  call dein#end()
  call dein#save_state()
endif

"Required:
filetype plugin indent on
syntax enable

"If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable


"--------------------------------------------------------------------------------
"---------------------------------Plugin Config----------------------------------
"--------------------------------------------------------------------------------
"Deoplete
let g:go_fmt_command="goimports"
let g:go_metalinter_autosave=1
let g:go_gocode_unimported_packages=1

let g:deoplete#enable_at_startup = 1
"Powerline Theme to use
let g:airline_powerline_fonts = 0
let g:airline_theme='base16_default'
let g:airline_solarized_bg='dark'
let g:tmuxline_powerline_separators = 0
"Shows all buffers
let g:airline#extensions#tabline#enabled = 1

"Ultisnips
let g:UltiSnipsExpandTrigger="<C-s>"
"Go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_alternate_mode = "vsplit"
let g:go_fmt_command = "goimports"
let g:go_highlight_variable_declarations = 1


"--------------------------------------------------------------------------------
"-----------------------------------Key Binds------------------------------------
"--------------------------------------------------------------------------------
"Sets leader key to space
let mapleader = "\<Space>"
"maps semi-colon(;) to colon(:)
nnoremap ; :
"Removes trailing whitepace on F5
:nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
"Go to next buffer
nnoremap <C-n> :bnext<CR>
"Go to previous buffer
nnoremap <C-b> :bprevious<CR>
"Close current buffer
nnoremap <C-v> :bdelete<CR>
"Exit to normal mode
imap jk <Esc>
"Comment
imap <C-c> <plug>NERDCommenterInsert

"Open up Denite and search in folder
nnoremap <Leader>pf :Denite file_rec <CR>
nnoremap <C-p> :Denite file_rec <CR>
"Open up Denite and search in buffer
nnoremap <Leader>pb :Denite buffer <CR>

"Open NerdTree
nnoremap <Leader>t :NERDTreeToggle <CR>

"Write file
nnoremap <Leader>w :w<CR>
"Quit File
nnoremap <Leader>q :q<CR>

"Normal Mode paste from register
nmap <Leader>p "+p
nmap <Leader>P "+P

"Visual Mode save to register
vmap <Leader>y "*y
"Visual mode paste from register
vmap <Leader>p "*p

"Tab completion for deoplete
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

"Go Specific
autocmd FileType go nmap <leader>b <Plug>(go-build)
autocmd FileType go set tabstop=4
autocmd FileType go set shiftwidth=4

if exists('$TMUX')
  autocmd FileType go nmap <leader>r :VimuxRunCommand("clear; go run ".bufname("%"))<CR>
else
  autocmd FileType go nmap <leader>r <Plug>(go-run)
endif





