" Skip initialization for vim-tiny or vim-small
if 0 | endif

scriptencoding utf-8

runtime! userautoload/common/*.vim
runtime! userautoload/plugins/init.vim

syntax on
filetype plugin indent on

" SEGV対策
if v:version >= 704
  set regexpengine=1
endif
