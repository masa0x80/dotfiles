if globpath(&runtimepath, '') !~# 'asyncomplete\.vim'
  finish
endif

imap <C-g><C-i> <Plug>(asyncomplete_force_refresh)
inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() . "\<CR>" : "\<CR>"
