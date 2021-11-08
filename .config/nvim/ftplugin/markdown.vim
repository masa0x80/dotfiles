" {{{ ALE config
if executable('prettier')
  let b:ale_linters = ['prettier']
  let b:ale_fixers = ['prettier']
endif
"}}}
