function! s:tab_indent(op)
  stopinsert
  echom virtcol('.')
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
  inoremap <silent> <buffer> <Tab> <Esc>:<C-u>call <SID>tab_indent('>')<CR>
  inoremap <silent> <buffer> <S-Tab> <Esc>:<C-u>call <SID>tab_indent('<')<CR>
endfunction

augroup IndentMapping
  autocmd BufNewFile,BufRead * call s:customize_indent_mappings()
augroup END
