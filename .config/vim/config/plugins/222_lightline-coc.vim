if globpath(&runtimepath, '') !~# 'lightline\.vim'
  finish
endif

if globpath(&runtimepath, '') !~# 'coc\.nvim'
  finish
endif

let g:lightline.component_function.coc = 'coc#status'
let g:lightline.active.right = add(g:lightline.active.right, ['coc'])
