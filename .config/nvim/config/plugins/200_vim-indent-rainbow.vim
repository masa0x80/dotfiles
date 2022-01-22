if globpath(&runtimepath, '') !~# 'vim-indent-rainbow'
  finish
endif

autocmd MyAutoCmd BufWinEnter,BufNewFile * call rainbow#enable()
