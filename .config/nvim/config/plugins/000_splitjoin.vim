if globpath(&runtimepath, '') !~# 'splitjoin\.vim'
  finish
endif

nmap <Leader>s :SplitjoinSplit<CR>
nmap <Leader>j :SplitjoinJoin<CR>
