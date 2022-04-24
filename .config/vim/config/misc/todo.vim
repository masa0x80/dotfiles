function! s:OpenFile(path)
  execute(':e ' . a:path)
endfunction

command! T call s:OpenFile(trim(system('fish -c "scrapbook_dir todo"')) . system('current_dir _'))
command! Todo call s:OpenFile(trim(system('fish -c "scrapbook_dir todo"')) . system('current_dir _'))

command! M call s:OpenFile(trim(system('fish -c "scrapbook_dir memo"')) . system('current_dir _'))
command! Memo call s:OpenFile(trim(system('fish -c "scrapbook_dir memo"')) . system('current_dir _'))
