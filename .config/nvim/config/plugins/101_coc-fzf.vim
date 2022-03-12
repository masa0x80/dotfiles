if globpath(&runtimepath, '') !~# 'coc-fzf'
  finish
endif

" allow to scroll in the preview
set mouse=a

" mappings
nnoremap <silent> <space>a :<C-u>CocFzfList diagnostics<CR>
nnoremap <silent> <space>b :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <silent> <space>c :<C-u>CocFzfList commands<CR>
nnoremap <silent> <space>e :<C-u>CocFzfList extensions<CR>
nnoremap <silent> <space>l :<C-u>CocFzfList location<CR>
nnoremap <silent> <space>o :<C-u>CocFzfList outline<CR>
nnoremap <silent> <space>s :<C-u>CocFzfList symbols<CR>
nnoremap <silent> <space>p :<C-u>CocFzfListResume<CR>

nnoremap <silent> <space>y :<C-u>CocFzfList yank<cr>
