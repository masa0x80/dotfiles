if globpath(&runtimepath, '') !~# 'vim-markdown'
  finish
endif

let g:vim_markdown_conceal = 0
let g:vim_markdown_folding_level = 6
