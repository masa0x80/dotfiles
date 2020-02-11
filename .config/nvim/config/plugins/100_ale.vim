if globpath(&runtimepath, '') !~# '\/ale\/'
  finish
endif

let g:ale_fix_on_save = 1
let g:ale_fixers = {
  \   'ruby': ['rubocop'],
  \   'javascript': ['prettier', 'eslint'],
  \   'typescript': ['prettier', 'eslint'],
  \ }
