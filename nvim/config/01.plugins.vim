" dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/yadunandprem/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/yadunandprem/.cache/dein')
  call dein#begin('/Users/yadunandprem/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/yadunandprem/.cache/dein/repos/github.com/Shougo/dein.vim')
  " Autocompletion
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('zchee/deoplete-jedi')
  call dein#add('autozimu/LanguageClient-neovim', {'rev': 'next', 'build': 'bash install.sh'})
  " Treeview
  call dein#add('scrooloose/nerdtree')
  " Vim Powerline
  call dein#add('vim-airline/vim-airline')
  " Tmux Powerline
  call dein#add('edkolev/tmuxline.vim')
  " Fish support
  call dein#add('dag/vim-fish')
  " Easier navigation between tmux and vim panes
  call dein#add('christoomey/vim-tmux-navigator')
  " Vim tmux integration
  call dein#add('benmills/vimux')
  " Fuzzy file finding
  call dein#add('junegunn/fzf.vim')
  call dein#add('/usr/local/opt/fzf')
  " Ale linter
  call dein#add('w0rp/ale')
  " Colortheme
  call dein#add('lifepillar/vim-solarized8')


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

" End dein Scripts-------------------------
