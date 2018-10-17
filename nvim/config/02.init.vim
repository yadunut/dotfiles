" Misc startup settings for vim

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

syntax on

" Better Backspace
set backspace=indent,eol,start

" Line Number
set number relativenumber

" Set ruler and cursorline
set ruler
" set cursorline

" Autoindentation
set autoindent
filetype indent plugin on

" Use spaces instead of tabs & set tabstop to 4 space
set expandtab
set softtabstop =4
set shiftwidth  =4
set shiftround

" Use ag instead of grep
set grepprg=ag\ --nogroup\ --nocolor

" Set colors
set termguicolors
colorscheme solarized8_dark_high

" Allow unsaved files to lose focus
set hidden

" Close vim if only buffer is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Set preview window height
" set previewheight =5
"
autocmd Filetype c,cpp setlocal expandtab softtabstop=2 shiftwidth=2
