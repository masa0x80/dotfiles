augroup NeomakeAug
  autocmd!
  autocmd BufReadPost,BufWritePre * Neomake
augroup END

call neomake#configure#automake('nrw', 500)
let g:neomake_ruby_enabled_makers = ['rubocop']
