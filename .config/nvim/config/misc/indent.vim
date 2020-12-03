function! s:current_cursor_char()
  let s = @"
  normal! yl
  let c = @"
  let @" = s
  return c
endfunction

function! s:tab_indent(op)
  let l:col = virtcol('.')
  let l:len = strlen(expand('<cword>'))
  call cursor(0, 1)
  if a:op == '>'
    " empty line
    if virtcol('$') == 1 && l:len == 0
      execute(':normal ' . &shiftwidth . 'i ')
      startinsert!
    " line tail
    elseif l:col == virtcol('$') - 1
      execute(':normal ' . &shiftwidth . 'i ')
      startinsert!
    " line head
    " XXX: cursorが2文字目の場合の挙動がおかしい
    elseif l:col == 1
      execute(':normal ' . &shiftwidth . 'i ')
      call cursor(0, l:col + &shiftwidth)
      startinsert
    else
      execute(':normal ' . &shiftwidth . 'i ')
      call cursor(0, l:col + &shiftwidth + 1)
      startinsert
    endif
  elseif a:op == '<'
    let l:char = s:current_cursor_char()
    " XXX: 先頭がスペースの場合、スペース以外の文字含めて
    "      &shiftwidth 文字削除してしまう。
    if l:char == ' '
      if l:col == col('$') - 1
        execute(':normal ' . &shiftwidth . 'x')
        startinsert!
      else
        execute(':normal ' . &shiftwidth . 'x')
        call cursor(0, l:col - &shiftwidth + 1)
        startinsert
      endif
    endif
  endif
endfunction

function! s:customize_indent_mappings() abort
  inoremap <silent> <buffer> <Tab> <Esc>:<C-u>call <SID>tab_indent('>')<CR>
  inoremap <silent> <buffer> <S-Tab> <Esc>:<C-u>call <SID>tab_indent('<')<CR>
endfunction

augroup MyAutoCmd IndentMapping
  autocmd FileType * call s:customize_indent_mappings()
augroup END
