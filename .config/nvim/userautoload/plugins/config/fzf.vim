autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

nnoremap <silent> <Leader>f :<C-u>Files<CR>
nnoremap <silent> <Leader>a :<C-u>Rg<CR>

" Rails
nnoremap <silent> <Leader>c :<C-u>GFiles<CR>app/controllers/
nnoremap <silent> <Leader>d :<C-u>GFiles<CR>db/migrate/
nnoremap <silent> <Leader>h :<C-u>GFiles<CR>app/helpers/
nnoremap <silent> <Leader>m :<C-u>GFiles<CR>app/models/
nnoremap <silent> <Leader>s :<C-u>GFiles<CR>app/serializers/
nnoremap <silent> <Leader>t :<C-u>GFiles<CR>spec/
nnoremap <silent> <Leader>v :<C-u>GFiles<CR>app/views/