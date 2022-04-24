if globpath(&runtimepath, '') !~# 'splitjoin\.vim'
  finish
endif

nmap <C-g>l :SplitjoinSplit<CR>
nmap <C-g>- :SplitjoinJoin<CR>
