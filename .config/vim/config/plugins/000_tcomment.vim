if globpath(&runtimepath, '') !~# 'tcomment_vim'
  finish
endif

nnoremap <C-c><C-c> :<C-u>TComment<CR>
vnoremap <C-c><C-c> :TComment<CR>
