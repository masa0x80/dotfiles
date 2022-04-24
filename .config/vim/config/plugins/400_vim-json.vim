if globpath(&runtimepath, '') !~# 'vim-json'
  finish
endif

let g:vim_json_syntax_conceal = 0
