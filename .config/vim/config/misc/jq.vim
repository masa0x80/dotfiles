" ref. http://qiita.com/tekkoc/items/324d736f68b0f27680b8
if executable('jq')
  function! s:Jq(...)
    if 0 == a:0
      let l:arg = "."
    else
      let l:arg = a:1
    endif
    execute "%! jq " . l:arg
  endfunction
  command! -nargs=? Jq call s:Jq(<f-args>)
endif
