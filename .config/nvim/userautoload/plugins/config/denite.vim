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

if executable('rg')
  call denite#custom#var('grep', 'command', ['rg', '--files', '--glob', '!.git'])
  call denite#custom#var('grep', 'command', ['rg', '--threads', '1'])
  call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--no-heading'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'separator', ['--'])
endif
