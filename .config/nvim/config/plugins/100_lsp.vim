if globpath(&runtimepath, '') !~# 'vim-lsp'
  finish
endif

" Use ALE
if globpath(&runtimepath, '') =~# '\/ale\/'
  let g:lsp_diagnostics_enabled = 0
endif

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gt <plug>(lsp-type-definition)
  nmap <buffer> <leader>rn <plug>(lsp-rename)
  nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
  nmap <buffer> K <plug>(lsp-hover)
  nmap <buffer> <leader>df <Plug>(lsp-document-format)

  let g:lsp_format_sync_timeout = 1000
  autocmd MyAutoCmd BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
  autocmd MyAutoCmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
