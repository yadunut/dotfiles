" Contains deoplete autocomplete settings

let g:deoplete#enable_at_startup =1
let g:deoplete#enable_smart_case =1
let g:deoplete_disable_auto_complete=1

" Disable autocompletion in comments and strings
call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])

" Set sources
call deoplete#custom#option('sources', {
            \ 'python': ['jedi'],
            \ 'python3': ['jedi'],
            \ 'rust' : ['LanguageClient'],
            \ 'c' : ['LanguageClient'],
            \ 'cpp' : ['LanguageClient'],
            \ 'vim' : ['vim'],
            \ 'ruby' : ['LanguageClient'],
            \ 'javascript' : ['LanguageClient'],
            \ 'sh' : ['LanguageClient'],
            \})
