nnoremap <C-g> :Gtags
nnoremap <Leader>h :Gtags -f %<CR>
nnoremap <C-j> :GtagsCursor<CR>
nnoremap <C-n> :cn<CR>
nnoremap <C-p> :cp<CR>

augroup AutoExecGlobal
  autocmd!
  autocmd BufWritePost * call s:global()
augroup END

function! s:global()
  if has('nvim')
    call jobstart('type -a global && test -s $(global -pr)/GTAGS && pkill -f global && global -uv')
  endif
endfunction
