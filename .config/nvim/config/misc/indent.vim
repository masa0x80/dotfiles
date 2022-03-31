function! s:tab_indent(op)
  stopinsert
  " 行末の処理をうまくするためにvirtualeditを一時的にallに変更
  let l:ve = &virtualedit
  set virtualedit=all
  let l:col = virtcol('.')
  if a:op == '>'
    " 空行
    if l:col == 1 && virtcol('$') == 1
      execute 'normal ' .. &shiftwidth .. 'i '
      startinsert!
    else
      execute '>'
      " FIXME: 2文字目にカーソルがある場合の挙動がおかしい
      if l:col == 1
        call cursor(0, l:col + &shiftwidth)
      else
        call cursor(0, l:col + &shiftwidth + 1)
      endif
    endif
  else
    execute '<'
    call cursor(0, l:col - &shiftwidth + 1)
  endif
  startinsert
  let &virtualedit=l:ve
endfunction

function! s:customize_indent_mappings() abort
  imap <silent> <buffer> <C-g><C-n> <Esc>:<C-u>call <SID>tab_indent('>')<CR>
  imap <silent> <buffer> <C-g><C-p> <Esc>:<C-u>call <SID>tab_indent('<')<CR>
endfunction

augroup IndentMapping
  if &ft != 'gina-status'
    autocmd BufNewFile,BufRead * call s:customize_indent_mappings()
  endif
augroup END
