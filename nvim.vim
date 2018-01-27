"--------------------------------------------------------------------------------
"------------------------Yadunand's Neovim Configuration-------------------------
"--------------------------------------------------------------------------------
"
"Sets line number and relative line number
set number
set relativenumber

"--------------------------------------------------------------------------------
"------------------------------------Plugins-------------------------------------
"--------------------------------------------------------------------------------
if &compatible
  set nocompatible
endif
set runtimepath+={path to dein.vim directory}

"dein Scripts-----------------------------
if &compatible
  set nocompatible
endif

"Required:
set runtimepath+=/Users/yadunand/.config/nvim/dein/repos/github.com/Shougo/dein.vim

"Required:
if dein#load_state('/Users/yadunand/.config/nvim/dein')
  call dein#begin('/Users/yadunand/.config/nvim/dein')

  "Let dein manage dein
  "Required:
  call dein#add('/Users/yadunand/.config/nvim/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:

  " You can specify revision/branch/tag.

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------


filetype plugin indent on
syntax enable


"--------------------------------------------------------------------------------
"-----------------------------------Key Binds------------------------------------
"--------------------------------------------------------------------------------

"maps semi-colon(;) to colon(:)
nnoremap ; :

