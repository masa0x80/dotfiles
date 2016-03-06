" Skip initialization for vim-tiny or vim-small
if 0 | endif

scriptencoding utf-8

runtime! userautoload/common/*.vim
runtime! userautoload/plugins/init.vim
runtime! userautoload/plugins/config/*.vim

syntax on
filetype plugin indent on

" SEGV対策
if !has('nvim') && v:version >= 704
  set regexpengine=1
endif
