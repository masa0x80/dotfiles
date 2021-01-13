if globpath(&runtimepath, '') !~# 'vim-edgemotion'
  finish
endif

map <C-g><C-j> <Plug>(edgemotion-j)
map <C-g><C-k> <Plug>(edgemotion-k)
