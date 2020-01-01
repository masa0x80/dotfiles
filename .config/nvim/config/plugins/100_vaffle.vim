if globpath(&runtimepath, '') !~# 'vaffle'
  finish
endif

let g:vaffle_show_hidden_files = 1

nnoremap <Leader>F :<C-u>Vaffle getcwd()<CR>
nnoremap - :<C-u>Vaffle<CR>
