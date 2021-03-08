if globpath(&runtimepath, '') !~# 'fern'
  finish
endif

function! s:customize_fern_mappings() abort
  nmap <buffer> h <Plug>(fern-action-leave)
  nmap <buffer> q :<C-u>bd<CR>
endfunction

augroup FernConfig
  autocmd MyAutoCmd FileType fern call s:customize_fern_mappings()
augroup END

nnoremap - :<C-u>Fern %:h -reveal=%:t<CR>
