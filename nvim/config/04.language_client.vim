" LanguageClient contains settings regarding language clients

let g:LanguageClient_serverCommands = {
      \ 'rust': ['/usr/bin/rustup', 'run', 'stable', 'rls'],
      \ 'cpp': ['/usr/local/bin/cquery', '--log-file=/tmp/cq.log'],
      \ 'c': ['/usr/local/bin/cquery', '--log-file=/tmp/cq.log'],
      \ 'javascript': ['/usr/local/bin/javascript-typescript-langserver'],
      \ 'ruby': ['/Users/yadunandprem/.rvm/gems/ruby-2.5.1/bin/solargraph', 'stdio'],
      \}
set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_rangeFormatting()
    
let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = '/Users/yadunandprem/.config/nvim/settings.json'

