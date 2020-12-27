if globpath(&runtimepath, '') !~# 'vim-molder-operations'
  finish
endif

function! s:customize_molder_operations_mappings() abort
  nmap <buffer> <silent> i :<c-u>call <SID>edit_file()<cr>
  nmap <buffer> <silent> d <plug>(molder-operations-delete)
  nmap <buffer> <silent> o <plug>(molder-operations-newdir)
  nmap <buffer> <silent> r <plug>(molder-operations-rename)
endfunction

function! s:edit_file() abort
  call feedkeys(':e ' .. molder#curdir(), 'n')
endfunction

augroup MolderOperationsConfig
  autocmd MyAutoCmd FileType molder call s:customize_molder_operations_mappings()
augroup END
