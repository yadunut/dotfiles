set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"Vundle needs to manage itself
Plugin 'VundleVim/Vundle.vim'

"Autocompletor and some syntax
"Plugin 'valloric/youcompleteme'

"Should put a status bar at the bottom of vim
Plugin 'bling/vim-airline'

"Themes for airline
Plugin 'vim-airline/vim-airline-themes'

"Enables file search in vim
Plugin 'scrooloose/nerdtree'

"Shows git diff on the sides
Plugin 'airblade/vim-gitgutter'

"Allows for fuzzy file search
Plugin 'kien/ctrlp.vim'

"Syntax checking
Plugin 'vim-syntastic/syntastic'

"Do vim motions easier
Plugin 'easymotion/vim-easymotion'

"Shows list of buffers
Plugin 'bling/vim-bufferline'

"Adds more language support
Plugin 'sheerun/vim-polyglot'

"Color Schemes
Plugin 'flazz/vim-colorschemes'

"TernJs
"Plugin 'ternjs/tern_for_vim'

"JavaScript
Plugin 'pangloss/vim-javascript'

"Org Mode
Plugin 'jceb/vim-orgmode'

"Visual Mode easier selection 
Plugin 'terryma/vim-expand-region'

"Dates
Plugin 'tpope/vim-speeddating'

call vundle#end()
filetype plugin indent on

"enables checking for filetype for syntax purposes
filetype on

"turns on syntax
syntax on

"For you Complete me
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

"For TernJs
"enable keyboard shortcuts
let g:tern_map_keys=1
"show argument hints
let g:tern_show_argument_hints='on_hold'

"For airline
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1

"For syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_include_dirs = ['/usr/local/include']


set smartindent
set tabstop=4
set shiftwidth=4
set number
set relativenumber
set ruler
set laststatus=2
set wildmenu
set backspace=2
colorscheme Tomorrow-Night-Bright
set background=dark

"Let map leader key to <space>
let mapleader = "\<Space>"

nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>d :bd<CR>
nnoremap <Leader><Leader> V
nnoremap <Leader>q :q<CR>
vmap <Leader>y "*y
vmap <Leader>d "*d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

noremap ; :

"Maps
"keeps cursor on centre of screen
set scrolloff=999
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" Quickly escape insert mode
inoremap jk <esc>

" Easy access to blackhole register
"nnoremap <Leader> "_

"Adds support for scolling through buffers
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>


" Disable all 6 arrow keys.
nnoremap <Left> :echo "No left for you!"<CR>
vnoremap <Left> :<C-u>echo "No left for you!"<CR>
nnoremap <Right> :echo "No right for you!"<CR>
vnoremap <Right> :<C-u>echo "No right for you!"<CR>
nnoremap <Up> :echo "No up for you!"<CR>
vnoremap <Up> :<C-u>echo "No up for you!"<CR>
nnoremap <Down> :echo "No down for you!"<CR>
vnoremap <Down> :<C-u>echo "No down for you!"<CR>


