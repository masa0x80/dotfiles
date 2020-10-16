if globpath(&runtimepath, '') !~# 'iceberg\.vim'
  finish
endif

autocmd MyAutoCmd VimEnter * colorscheme iceberg
