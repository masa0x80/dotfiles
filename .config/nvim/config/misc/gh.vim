if executable('gh')
  function! s:GhOpenRepo()
    execute "!gh browse"
  endfunction
  command! GhOpenRepo call s:GhOpenRepo()

  function! s:GhOpenFile()
    let s:branch = trim(system('fish -c "git_current_brandh"'))
    execute '!gh browse ' . expand('%') . ' --branch ' . s:branch
  endfunction
  command! GhOpenFile call s:GhOpenFile()

  function! s:GhOpenPR()
    execute '!gh pr view --web'
  endfunction
  command! GhOpenPR call s:GhOpenPR()
endif
