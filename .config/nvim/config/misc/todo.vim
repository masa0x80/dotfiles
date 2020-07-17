function! s:Todo()
  execute(':e $SCRAPBOOK_DIR/todo/' . system('current_dir _'))
endfunction
command! T call s:Todo()
command! Todo call s:Todo()
