" {{{ ALE config
if executable('eslint')
  let b:ale_linters = ['eslint']
  let b:ale_fixers = ['eslint']
else
  let b:ale_linters = ['prettier']
  let b:ale_fixers = ['prettier']
endif
"}}}
