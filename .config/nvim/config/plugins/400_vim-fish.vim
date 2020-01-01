if globpath(&runtimepath, '') !~# 'vim-fish'
  finish
endif

function! s:fish_indent()
  let l:line = line('.')
  " NOTE: Require 'dag/vim-fish'
  normal gggqG
  execute ':' . l:line
endfunction
autocmd MyAutoCmd BufWritePre *.fish call <SID>fish_indent()
