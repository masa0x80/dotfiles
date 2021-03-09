if globpath(&runtimepath, '') !~# 'fzf'
  finish
endif

autocmd MyAutoCmd FileType fzf
  \  set laststatus=0 noshowmode noruler
  \| autocmd MyAutoCmd BufLeave <buffer> set laststatus=2 showmode ruler

nnoremap <silent> <Leader>f :<C-u>Files<CR>
nnoremap <silent> <Leader><Leader> :<C-u>Buffers<CR>
