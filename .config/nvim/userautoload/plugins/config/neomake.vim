augroup NeomakeAug
  autocmd!
  autocmd BufWritePre *.rb,*.spec,*.rake call s:neomake_wrapper()
augroup END

function! s:neomake_wrapper()
  if filereadable(findfile('.rubocop.yml'))
    Neomake
  endif
endfunction

let g:neomake_ruby_enabled_makers = ['rubocop']
