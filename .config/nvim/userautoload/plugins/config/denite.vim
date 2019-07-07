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

call denite#custom#var('file/rec', 'command', ['files'])

if executable('pt')
  call denite#custom#var('grep', 'command', ['pt', '--nogroup', '--nocolor', '--smart-case', '--hidden'])
  call denite#custom#var('grep', 'default_opts', [])
  call denite#custom#var('grep', 'recursive_opts', [])
endif
