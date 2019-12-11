if &compatible
    set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/yadunandprem/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('/Users/yadunandprem/.cache/dein')
    call dein#begin('/Users/yadunandprem/.cache/dein')

    " Let dein manage dein
    " Required:
    call dein#add('/Users/yadunandprem/.cache/dein/repos/github.com/Shougo/dein.vim')

    call dein#add('neoclide/coc.nvim', {'merge':0,'rev': 'release'})

    call dein#add('scrooloose/nerdtree')                " Treeview
    call dein#add('scrooloose/nerdcommenter')           " Commenting

    call dein#add('/usr/local/opt/fzf')                 " Fuzzy File Finding
    call dein#add('junegunn/fzf.vim')                   " Fuzzy File Finding

    call dein#add('vim-airline/vim-airline')            " Vim statusline
    call dein#add('vim-airline/vim-airline-themes')     " Statusline themes
    call dein#add('edkolev/tmuxline.vim')               " Tmux statusline
    call dein#add('dracula/vim')			" Darcula Theme
    call dein#add('maxmellon/vim-jsx-pretty')           " JSX
    call dein#add('sheerun/vim-polyglot')               " Syntax highlighting

    " Required:
    call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

if dein#check_install()
    call dein#install()
endif

" Plugin Settings

" Tmuxline
let g:tmuxline_powerline_separators = 1

" Vim Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='dracula'
let g:airline_powerline_fonts = 1


" NerdCommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1

" Fzf
let $FZF_DEFAULT_COMMAND = 'ag -g ""'


" Set Colorscheme
colorscheme dracula

" settings

set nobackup		" Don't create backups when overwriting files
set nowritebackup	" Don't create backups when overwriting files


set updatetime=300	" Swapfile written to disk every 300ms

set shortmess+=c	" don't give |ins-completion-menu| messages.

" Search Options
set incsearch
set ignorecase
set smartcase

set cmdheight=2		" Better display for messages
set signcolumn=yes 	" always show signcolumns

set number
set relativenumber

set ruler
set autowrite
set hidden 		" Allow moving to unsaved files

set expandtab " Use spaces instead of tabs 👿
set autoindent
set tabstop=8
set softtabstop=2
set shiftwidth=2
set smarttab

set wildignorecase

set noswapfile

set termguicolors




" Keybinds

" Better escape
imap jk <Esc>
" Map Semicolon to colon
nnoremap ; :

" Buffer control
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
nnoremap <C-b> :bdelete<CR>

nnoremap <space>t :NERDTreeToggle<CR>
nnoremap <C-f> :Files<CR>

" clipboard operations
nmap <leader>yy "*yy
nmap <leader>p "+p
vmap <leader>y "+y

" Remove trailing space
nnoremap <leader>tr :call TrimWhiteSpace() <CR>



" Tab for autocompletion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" C-Space to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
"
" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

command! TrimWhiteSpace call TrimWhiteSpace()

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Marketplace
nnoremap <silent> <space>m  :<C-u>CocList marketplace<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Functions

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! TrimWhiteSpace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfunction

" Autocmds

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
