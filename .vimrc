scriptencoding utf-8

runtime! userautoload/init/*.vim
runtime! userautoload/plugins/*.vim

" SEGV対策
if v:version >= 704
  set regexpengine=1
endif
