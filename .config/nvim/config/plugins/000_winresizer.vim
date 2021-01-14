if globpath(&runtimepath, '') !~# 'winresizer'
  finish
endif

let g:winresizer_start_key = ',<C-r>'
let g:winresizer_start_key = '<Leader><C-r>'
