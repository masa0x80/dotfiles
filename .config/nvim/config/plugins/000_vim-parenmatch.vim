if globpath(&runtimepath, '') !~# 'vim-parenmatch'
  finish
endif

" Use vim-parenmatch instead of parenmatch
let g:loaded_matchparen = 1
