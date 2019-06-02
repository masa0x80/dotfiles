" Skip initialization for vim-tiny or vim-small
if 0 | endif

scriptencoding utf-8

runtime! userautoload/common/*.vim
if filereadable(findfile('$HOME/.config.local/nvim/common.vim'))
  source $HOME/.config.local/nvim/common.vim
endif
if has('nvim')
  runtime! userautoload/plugins/init.vim
endif

syntax on
filetype plugin indent on
