" vim-airline tabline
let g:airline#extensions#tabline#enabled = 1
" NerdTree
let NERDTreeHighlightCursorline = 0
" Tmuxline
let g:tmuxline_powerline_separators = 0
" Vimux Config
let g:VimuxOrientation = "h"
" Ale config
let g:ale_fixers = {
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \ 'cpp': ['clang-format'],
            \ 'c': ['clang-format'],
            \ 'ruby': ['rubocop'],
            \ 'sh': ['shfmt'],
            \ }
let g:ale_fix_on_save = 1
" NERDComment Settings
let g:NERDSpaceDelims = 1

let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
