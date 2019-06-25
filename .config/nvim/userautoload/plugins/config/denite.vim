call denite#custom#option('_', {
  \ 'prompt': '> ',
  \ 'cached_filter': v:true,
  \ 'cursor_shape': v:true,
  \ 'cursor_wrap': v:true,
  \ 'split': 'floating'
  \ })

" NOTE: depends = 'lightline.vim'
if dein#tap('lightline.vim')
  call denite#custom#option('default', 'statusline', v:false)
endif

call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command', ['git', 'ls-files', '-co', '--exclude-standard'])

call denite#custom#source('buffer', 'matchers', ['matcher/cpsm'])
call denite#custom#source('file/rec', 'matchers', ['matcher/cpsm'])
call denite#custom#source('file/rec/git', 'matchers', ['matcher/cpsm'])

if executable('pt')
  call denite#custom#var('grep', 'command', ['pt', '--nogroup', '--nocolor', '--smart-case', '--hidden'])
  call denite#custom#var('grep', 'default_opts', [])
  call denite#custom#var('grep', 'recursive_opts', [])
endif
