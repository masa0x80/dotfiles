if globpath(&runtimepath, '') !~# '\/ale\/'
  finish
endif

let g:ale_fix_on_save = 1
let g:ale_hover_cursor = 0
let g:ale_fixers = {
  \   'ruby': ['rubocop'],
  \   'javascript': ['prettier', 'eslint'],
  \   'typescript': ['prettier', 'eslint'],
  \ }

function! s:ToggleALEAutoFix()
  let g:ale_fix_on_save = !get(g:, 'ale_fix_on_save')
endfunction
command! -nargs=0 ToggleALEAutoFix call s:ToggleALEAutoFix()
