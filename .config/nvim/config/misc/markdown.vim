if executable('markdown2confluence')
  function! s:markdown_indent(op)
    let l:col = col('.')
    call cursor(0, 1)
    if a:op == '>'
      execute(':normal ' . &shiftwidth . 'i' . ' ')
      call cursor('.', l:col + &shiftwidth)
    elseif a:op == '<'
      execute(':normal ' . &shiftwidth . 'x')
      call cursor('.', l:col - &shiftwidth)
    endif
    startinsert!
  endfunction
  autocmd MyAutoCmd FileType markdown inoremap <silent> <buffer> <Tab> <Esc>:<C-u>call <SID>markdown_indent('>')<CR>
  autocmd MyAutoCmd FileType markdown inoremap <silent> <buffer> <S-Tab> <Esc>:<C-u>call <SID>markdown_indent('<')<CR>

  function! s:generate_confluence_markup()
    let l:out = '/tmp/' . strftime('%FT%T') . '.confluence'
    silent execute '%y'
    execute 'edit ' . l:out
    silent execute 'put!'
    silent execute 'write'
    silent execute '0read !cat ' . l:out . ' | markdown2confluence'
    silent execute (line('.') + 1) . ',$d'
    silent execute '%y'
  endfunction
  command! Md2Confluence call <SID>generate_confluence_markup()
endif
