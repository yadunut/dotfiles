" Contains deoplete autocomplete settings

let g:deoplete#enable_at_startup =1
let g:deoplete#enable_smart_case =1
let g:deoplete_disable_auto_complete=1

" Disable autocompletion in comments and strings
call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])

" Set sources
let g:deoplete#sources = {}
let g:deoplete#sources.python = ['jedi']
let g:deoplete#sources.python3 = ['jedi']
let g:deoplete#sources.vim = ['vim']
let g:deoplete#sources.rust = ['LanguageClient']
let g:deoplete#sources.c = ['LanguageClient']
let g:deoplete#sources.cpp = ['LanguageClient']
let g:deoplete#sources.javascript = ['LanguageClient']
let g:deoplete#sources.ruby = ['LanguageClient']
