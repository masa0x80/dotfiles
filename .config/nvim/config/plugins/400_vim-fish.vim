if globpath(&runtimepath, '') !~# 'vim-fish'
  finish
endif

function! s:fish_indent()
  " NOTE: Require 'dag/vim-fish'
  normal gggqG
  execute "normal \<C-o>"
endfunction
autocmd MyAutoCmd BufWritePre *.fish call <SID>fish_indent()
