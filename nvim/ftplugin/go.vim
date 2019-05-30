if exists('$TMUX')
    autocmd Filetype go nnoremap <buffer> <leader>r :call VimuxRunCommand("go run " . bufname("%"))<CR>
endif
