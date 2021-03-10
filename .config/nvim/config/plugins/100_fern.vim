if globpath(&runtimepath, '') !~# 'fern'
  finish
endif

let g:fern#default_hidden = 1
let g:fern#renderer = 'nerdfont'

function! s:customize_fern_mappings() abort
  nmap <buffer> h <Plug>(fern-action-leave)
  nmap <buffer> q :<C-u>bd<CR>
endfunction
autocmd MyAutoCmd FileType fern call s:customize_fern_mappings()

nnoremap - :<C-u>Fern %:h -reveal=%:t<CR>
