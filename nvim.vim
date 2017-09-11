set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab number relativenumber scrolloff=999

"Keymaps
"Sets leader key to space
let mapleader = "\<Space>"

"Cycles through buffers
nnoremap <Leader>n :bnext<CR>
nnoremap <Leader>b :bprevious<CR>
nnoremap <C-n> :bnext<CR>
nnoremap <C-b> :bprevious<CR>
"Deletes current buffer (kill)
nnoremap <Leader>k :bdelete<CR>
"Opens fuzzy file finder
nnoremap <C-p> :Denite file_rec buffer<CR>
nnoremap <Leader>o :Denite file_rec buffer<CR>
"Opens new split and launches Denite
nnoremap <Leader>\ :vsp<CR><C-w>l :Denite file_rec buffer<CR>
nnoremap <Leader>- :sp<CR><C-w>j :Denite file_rec buffer<CR>
"Saves current file
nnoremap <Leader>w :w<CR>
"Closes window / current pane
nnoremap <Leader>q :q<CR>
"To read and write to system register
vmap <Leader>y "*y
vmap <Leader>d "*d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P


"Airline settings
"Enables powerline
let g:airline_powerline_fonts = 1
"Adds tabline
let g:airline#extensions#tabline#enabled = 1
"Sets the theme
let g:airline_theme='base16_default'
"let g:airline_solarized_bg='dark'


"Deoplete settings
"Launches at start
let g:deoplete#enable_at_startup = 1
"Enables tab to autocomplete
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

"Dein is a plugin manager
"Dein Config stuff start
if &compatible
  set nocompatible
endif
set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim
"Dein config stuff end

"Dein Plugins
if dein#load_state('~/.config/nvim/dein')
    call dein#begin('~/.config/nvim/dein')
    "Dein needs to call itself
    call dein#add('~/.config/nvim/dein/repos/github.com/Shougo/dein.vim')
    "Autocomplete
    call dein#add('Shougo/deoplete.nvim')
    "Helm(emacs) like fuzzy file / buffer search
    call dein#add('Shougo/denite.nvim')
    "Powerline
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    "Commenter
    call dein#add('scrooloose/nerdcommenter')
    "Better vim-tmux split/pane controls
    call dein#add('christoomey/vim-tmux-navigator')
    "Elixir
    call dein#add('slashmili/alchemist.vim')
    call dein#add('elixir-lang/vim-elixir')
    "Autopairs brackets
    call dein#add('jiangmiao/auto-pairs')
    "Markdown
    call dein#add('shime/vim-livedown')
    "HTML auto Tag Closing
    call dein#add('alvan/vim-closetag')
    "For javascript completion
    call dein#add('carlitux/deoplete-ternjs')
    
    if dein#check_install()
        call dein#install()
    endif
    call dein#end()
    call dein#save_state()
endif
filetype plugin indent on
syntax enable


