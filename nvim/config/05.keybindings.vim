" Keybinds

" Set leader key to space
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
" Save file
nnoremap <Leader>w :w<CR>
" Quit file
nnoremap <Leader>q :q<CR>
" Open NERDTree
nnoremap <Leader>t :NERDTreeToggle<CR>

" Save Line to clipboard
nmap <Leader>yy "*yy
" Paste from clipboard
nmap <Leader>p "+p
" Visual mode save to clipboard
vmap <Leader>y "*y
" Visual mode paste from clipboard
vmap <Leader>p "*p
" Open Search
nmap <C-p> :Files<CR>
" Tab Completion
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

" Language Server Settings

function LC_maps()
    if has_key(g:LanguageClient_serverCommands, &filetype)
        nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<cr>
        nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
        nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
        nnoremap <F5> :call LanguageClient_contextMenu()<CR>
        " Sets column which shows errors on side to be open
        set signcolumn=yes
    endif
endfunction

autocmd FileType * call LC_maps()

if exists('$TMUX')
    autocmd FileType cpp nnoremap <leader>r :call VimuxRunCommand("./compile.sh " . bufname("%"))<CR>
endif
