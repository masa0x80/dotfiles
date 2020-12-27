if globpath(&runtimepath, '') !~# 'asyncomplete\.vim'
  finish
endif

inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() : "\<CR>"
