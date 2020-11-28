function! s:current_cursor_char()
  let s = @"
  normal! yl
  let c = @"
  let @" = s
  return c
endfunction

function! s:tab_indent(op)
  let l:col = col('.') + 1
  call cursor(0, 1)
  if a:op == '>'
    execute(':normal ' . &shiftwidth . 'i' . ' ')
    call cursor(0, l:col + &shiftwidth)
  elseif a:op == '<'
    let l:char = s:current_cursor_char()
    if l:char == ' '
      execute(':normal ' . &shiftwidth . 'x')
      call cursor(0, l:col - &shiftwidth)
    endif
  endif
  startinsert
endfunction
inoremap <silent> <buffer> <Tab> <Esc>:<C-u>call <SID>tab_indent('>')<CR>
inoremap <silent> <buffer> <S-Tab> <Esc>:<C-u>call <SID>tab_indent('<')<CR>
