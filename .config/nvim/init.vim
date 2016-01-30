" Skip initialization for vim-tiny or vim-small
if 0 | endif

scriptencoding utf-8

runtime! userautoload/init/*.vim
if isdirectory(expand('$HOME/.vim/plugged'))
  runtime! userautoload/plugins/*.vim
endif

" SEGV対策
if !has('nvim') && v:version >= 704
  set regexpengine=1
endif
