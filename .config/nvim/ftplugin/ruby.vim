iabbrev bb require 'pry'; binding.pry<Esc>
iabbrev BB require 'byebug'; byebug<Esc>
iabbrev Bb binding.irb<Esc>

setlocal foldmethod=indent

" {{{ ALE config
if executable('rubocop')
  let b:ale_linters = ['rubocop']
  let b:ale_fixers = ['rubocop']
elseif executable('prettier')
  let b:ale_linters = ['standardrb']
  let b:ale_fixers = ['standardrb']
endif
"}}}
