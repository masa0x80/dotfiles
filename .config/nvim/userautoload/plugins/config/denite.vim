nnoremap <silent> <Leader>f :<C-u>Denite file_rec<CR>
nnoremap <silent> <Leader>b :<C-u>Denite buffer<CR><C-o>
nnoremap <silent> <Leader>j :<C-u>Denite line<CR>
nnoremap <silent> <Leader>r :<C-u>Denite -resume<CR>

" grep
nnoremap <silent> <Leader>g :<C-u>Denite grep:.<CR>
nnoremap <silent> <leader>G :<C-u>Denite grep:. -input=<C-r><C-w><CR>
