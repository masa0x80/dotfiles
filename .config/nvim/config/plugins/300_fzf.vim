if globpath(&runtimepath, '') !~# 'fzf'
  finish
endif

autocmd MyAutoCmd FileType fzf
  \  set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

nnoremap <silent> <Leader>f :<C-u>Files<CR>
nnoremap <silent> <Leader>b :<C-u>Buffers<CR>
if executable('rg')
  nnoremap <silent> <Leader>g :<C-u>Rg<CR>
  nnoremap <silent> <Leader>G :<C-u>Rg <C-r><C-w><CR>
endif
