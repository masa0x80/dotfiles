function! s:Todo()
  execute(':e $SCRAPBOOK_DIR/todo/' . system('current_dir _'))
endfunction
command! T call s:Todo()
command! Todo call s:Todo()

function! s:Memo()
  execute(':e $SCRAPBOOK_DIR/memo/' . system('current_dir _'))
endfunction
command! T call s:Memo()
command! Todo call s:Memo()
