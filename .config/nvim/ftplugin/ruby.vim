iabbrev bb require 'pry'; binding.pry<Esc>
iabbrev BB require 'byebug'; byebug<Esc>
iabbrev Bb binding.irb<Esc>

setlocal foldmethod=indent

" {{{ ALE config
function! s:set_ale_config_for_ruby() abort
  let l:root_path = system('git rev-parse --show-toplevel 2>/dev/null | tr -d "\n"')
  if l:root_path == ''
    let l:root_path = getcwd()
  endif
  if executable('rubocop') && filereadable(l:root_path . '/.rubocop.yml')
    let b:ale_linters = ['rubocop']
    let b:ale_fixers = ['rubocop']
  elseif executable('standardrb')
    let b:ale_linters = ['standardrb']
    let b:ale_fixers = ['standardrb']
  endif
endfunction
call s:set_ale_config_for_ruby()
"}}}
