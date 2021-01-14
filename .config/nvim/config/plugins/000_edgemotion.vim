if globpath(&runtimepath, '') !~# 'vim-edgemotion'
  finish
endif

nmap <C-g><C-j> <Plug>(edgemotion-j)
vmap <C-g><C-j> <Plug>(edgemotion-j)
nmap <C-g><C-k> <Plug>(edgemotion-k)
vmap <C-g><C-k> <Plug>(edgemotion-k)
