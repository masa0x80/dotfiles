call denite#custom#option('default', 'prompt', '>')

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

call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>')
call denite#custom#map('insert', '<C-f>', '<denite:scroll_page_forwards>')
call denite#custom#map('insert', '<C-u>', '<denite:scroll_window_upwards>')
call denite#custom#map('insert', '<C-f>', '<denite:move_caret_to_right>')
call denite#custom#map('insert', '<C-b>', '<denite:move_caret_to_left>')
call denite#custom#map('insert', '<C-a>', '<denite:move_caret_to_head>')
call denite#custom#map('insert', '<C-e>', '<denite:move_caret_to_tail>')
