if globpath(&runtimepath, '') !~# 'winresizer'
  finish
endif

let g:winresizer_start_key = ',<C-r>'
