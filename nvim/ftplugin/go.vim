if exists('$TMUX')
    autocmd Filetype go nnoremap <buffer> <leader>r :call VimuxRunCommand("go run " . bufname("%"))<CR>
endif

set tabstop=4
set sts=4
set sw=4
