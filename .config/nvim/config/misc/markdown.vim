if executable('markdown2confluence')
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
