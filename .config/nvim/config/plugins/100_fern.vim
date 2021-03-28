if globpath(&runtimepath, '') !~# 'fern'
  finish
endif

let g:fern#disable_default_mappings = 1
let g:fern#default_hidden = 1
let g:fern#renderer = 'nerdfont'

function! s:customize_fern_mappings() abort
  nmap <buffer><nowait> i <Plug>(fern-action-new-file)
  nmap <buffer><nowait> o <Plug>(fern-action-new-dir)
  nmap <buffer><nowait> c <Plug>(fern-action-copy)
  nmap <buffer><nowait> m <Plug>(fern-action-move)
  nmap <buffer><nowait> d <Plug>(fern-action-trash)
  nmap <buffer><nowait> r <Plug>(fern-action-rename)

  nmap <buffer><nowait> y <Plug>(fern-action-yank)

  nmap <buffer><nowait> <C-j> <Plug>(fern-action-mark)j
  nmap <buffer><nowait> <C-k> k<Plug>(fern-action-mark)
  nmap <buffer><nowait> <C-i> <Plug>(fern-action-mark)
  vmap <buffer><nowait> <C-i> <Plug>(fern-action-mark)

  nmap <buffer><nowait> e <Plug>(fern-action-open)
  nmap <buffer><nowait> <C-m> <Plug>(fern-action-open)
  nmap <buffer><nowait> l <Plug>(fern-action-open-or-expand)
  nmap <buffer><nowait> - <Plug>(fern-action-leave)
  nmap <buffer><nowait> h <Plug>(fern-action-leave)
  nmap <buffer><nowait> <C-h> <Plug>(fern-action-collapse)
  nmap <buffer><nowait> s <Plug>(fern-action-open:select)
  nmap <buffer><nowait> E <Plug>(fern-action-open:side)
  nmap <buffer><nowait> t <Plug>(fern-action-open:tabedit)
  nmap <buffer><nowait> <Backspace> <C-h>

  nmap <buffer><nowait> z <Plug>(fern-action-zoom)

  nmap <buffer><nowait> !  <Plug>(fern-action-hidden)
  nmap <buffer><nowait> / <Plug>(fern-action-include)
  nmap <buffer><nowait> fi <Plug>(fern-action-include)
  nmap <buffer><nowait> fe <Plug>(fern-action-exclude)

  nmap <buffer><nowait> <C-c> <Plug>(fern-action-cancel)
  nmap <buffer><nowait> <C-l> <Plug>(fern-action-redraw)

  nmap <buffer><nowait> q :<C-u>bd<CR>
endfunction
autocmd MyAutoCmd FileType fern call s:customize_fern_mappings()

nnoremap - :<C-u>Fern %:h -reveal=%:t<CR>
