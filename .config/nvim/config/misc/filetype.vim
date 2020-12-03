function! s:SetFileType(...)
  if 0 == a:0
    let l:type = 'markdown'
  else
    let l:type = a:1
  endif
  execute 'set filetype=' . l:type
endfunction
command! -nargs=? F call s:SetFileType(<f-args>)
