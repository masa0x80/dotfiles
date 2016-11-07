nnoremap <silent> <Leader>f :<C-u>Denite file_rec<CR><C-o>
nnoremap <silent> <Leader>b :<C-u>Denite buffer<CR><C-o>
nnoremap <silent> <Leader>j :<C-u>Denite line<CR>

" grep
nnoremap <silent> <Leader>g :<C-u>Denite grep:.<CR>
nnoremap <silent> <leader>G :<C-u>Denite grep:. -input=<C-r><C-w><CR>
if dein#tap('denite')
  if executable('pt')
    call denite#custom#var('file_rec', 'command', ['pt', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', ''])
    call denite#custom#var('grep', 'command', ['pt', '--nogroup', '--nocolor', '--smart-case', '--hidden'])
    call denite#custom#var('grep', 'default_opts', [])
    call denite#custom#var('grep', 'recursive_opts', [])
  endif
endif
