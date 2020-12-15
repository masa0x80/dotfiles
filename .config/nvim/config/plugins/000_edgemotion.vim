if globpath(&runtimepath, '') !~# 'vim-edgemotion'
  finish
endif

map <C-j> <Plug>(edgemotion-j)
map <C-k> <Plug>(edgemotion-k)
