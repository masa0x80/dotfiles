if globpath(&runtimepath, '') !~# 'vim-molder'
  finish
endif

let g:molder_show_hidden = 1

function! s:customize_molder_mappings() abort
  nmap <buffer> <silent> <C-l> <plug>(molder-reload)
  nmap <buffer> <silent> l <plug>(molder-open)
  nmap <buffer> <silent> h <plug>(molder-up)
endfunction

augroup MyAutoCmd MolderConfig
  autocmd FileType molder call s:customize_molder_mappings()
augroup END

nnoremap - :<C-u>e %:p:h<CR>
nnoremap <Leader>- :<C-u>e %:p:h<CR>
