if globpath(&runtimepath, '') !~# '\/ale\/'
  finish
endif

let g:ale_fix_on_save = 1
let g:ale_hover_cursor = 0

let g:ale_fixers = {
  \   'ruby': ['rubocop'],
  \   'javascript': ['standard', 'eslint'],
  \   'typescript': ['standard', 'eslint'],
  \   'markdown': ['prettier'],
  \   'html': ['prettier'],
  \   'json': ['prettier'],
  \   'yaml': ['prettier'],
  \   'fish': ['fish_indent'],
  \ }

let g:ale_javascript_eslint_suppress_missing_config = 1

function! s:ToggleALEAutoFix()
  let g:ale_fix_on_save = !get(g:, 'ale_fix_on_save')
endfunction
command! -nargs=0 ToggleALEAutoFix call s:ToggleALEAutoFix()
