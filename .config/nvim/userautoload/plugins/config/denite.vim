let s:denite_win_width_percent = 0.5
let s:denite_win_height_percent = 0.7

call denite#custom#option('_', {
  \ 'prompt': '> ',
  \ 'cached_filter': v:true,
  \ 'cursor_shape': v:true,
  \ 'cursor_wrap': v:true,
  \ 'split': 'floating',
  \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
  \ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
  \ 'winheight': float2nr(&lines * s:denite_win_height_percent),
  \ 'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) / 2),
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
