let s:initial_font_size = 16
let s:font_size = s:initial_font_size
let s:font_family = 'Iosevka\ Nerd\ Font\ Mono'

function! s:ResetFontSize()
  let s:font_size = s:initial_font_size
  :execute 'set guifont=' .. s:font_family .. ':h' .. s:font_size
endfunction
autocmd MyAutoCmd VimEnter call <SID>ResetFontSize()
"
function! s:AdjustFontSize(amount)
  let s:font_size = s:font_size + a:amount
  :execute 'set guifont=' .. s:font_family .. ':h' .. s:font_size
endfunction

noremap <D-0> :call <SID>ResetFontSize()<CR>
noremap <D-=> :call <SID>AdjustFontSize(1)<CR>
noremap <D--> :call <SID>AdjustFontSize(-1)<CR>
