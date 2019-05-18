let g:neomake_tempfile_dir = '/tmp/neomake%:p:h'

augroup NeomakeAug
  autocmd!
  autocmd BufReadPost,BufWritePre * Neomake
augroup END

call neomake#configure#automake('nrw', 500)
