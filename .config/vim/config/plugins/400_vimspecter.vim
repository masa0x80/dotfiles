if globpath(&runtimepath, '') !~# 'vimspector'
  finish
endif

let g:vimspector_base_dir = expand('$XDG_CONFIG_HOME/vimspector-config')

function! s:customize_vimsppector_mappings() abort
  nnoremap <Leader>dd :call vimspector#Launch()<CR>
  nnoremap <Leader>de :call vimspector#Reset()<CR>
  nnoremap <Leader>dc :call vimspector#Continue()<CR>

  nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
  nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

  nmap <Leader>d_ <Plug>VimspectorRestart
  nmap <Leader>k <Plug>VimspectorStepOut
  nmap <Leader>l <Plug>VimspectorStepInto
  nmap <Leader>j <Plug>VimspectorStepOver
endfunction
autocmd MyAutoCmd FileType javascript,typescript call <SID>customize_vimsppector_mappings()
