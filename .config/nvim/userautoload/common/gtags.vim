nnoremap <C-g> :Gtags
nnoremap <C-h> :Gtags -f %<CR>
nnoremap <C-j> :GtagsCursor<CR>
nnoremap <C-n> :cn<CR>
nnoremap <C-p> :cp<CR>

augroup AutoExecGlobal
  autocmd!
  autocmd BufWritePost * call s:global()
augroup END

function! s:global()
  if !s:is_global_running()
    let s:global_pid = vimproc#popen2('global -uv')['pid']
  endif
endfunction

function! s:is_global_running()
  if exists('s:global_pid')
    return vimproc#kill('s:global_pid', 0) == 0
  else
    return 0
  endif
endfunction
