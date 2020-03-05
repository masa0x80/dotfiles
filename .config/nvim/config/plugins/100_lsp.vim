if globpath(&runtimepath, '') !~# 'vim-lsp'
  finish
endif

" Use ALE
if globpath(&runtimepath, '') =~# '\/ale\/'
  let g:lsp_diagnostics_enabled = 0
endif

nnoremap <silent> gd :LspDefinition<CR>
nnoremap <silent> gr :LspReferences<CR>
nnoremap <silent> <leader>d :LspDefinition<CR>
nnoremap <silent> <leader>r :LspReferences<CR>
nnoremap <silent> K :LspHover<CR>
nnoremap <silent> <leader>lr :LspRename<CR>
nnoremap <silent> <leader>lf :LspDocumentFormat<CR>
