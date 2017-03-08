" Skip initialization for vim-tiny or vim-small
if 0 | endif

scriptencoding utf-8

runtime! userautoload/common/*.vim
if filereadable(findfile('$HOME/.config.local/nvim/common.vim'))
  source $HOME/.config.local/nvim/common.vim
endif
runtime! userautoload/plugins/init.vim

syntax on
filetype plugin indent on
