vim.cmd([[
let g:ale_disable_lsp = 1
let g:ale_fix_on_save = 1
let g:ale_hover_cursor = 0

if executable(getcwd() .. '/vendor/bin/rubocop')
  let g:ale_ruby_rubocop_executable = 'bundle'
endif

" Disable all linters
"   When set to 1, only the linters from g:ale_linters and b:ale_linters
"   will be enabled. The default behavior for ALE is to enable as many linters
"   as possible, unless otherwise specified.
let g:ale_linters_explicit = 1

" 巨大なJSONのフォーマットを null-ls に任せると遅いので、JSON には ALE を使います
let g:ale_fixers = {
  \   'json': ['prettier'],
  \   'ruby': ['rubocop'],
  \ }

function! ToggleALEAutoFix()
  let g:ale_fix_on_save = !get(g:, 'ale_fix_on_save')
endfunction
command! -nargs=0 ToggleALEAutoFix call ToggleALEAutoFix()
]])
