if globpath(&runtimepath, '') !~# 'splitjoin\.vim'
  finish
endif

nmap ss :SplitjoinSplit<CR>
nmap sj :SplitjoinJoin<CR>
