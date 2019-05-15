call denite#custom#option('default', 'prompt', '>')

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

call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>')
call denite#custom#map('insert', '<C-u>', '<denite:scroll_window_upwards>')
call denite#custom#map('insert', '<C-d>', '<denite:scroll_page_forwards>')
call denite#custom#map('insert', '<C-f>', '<denite:move_caret_to_right>')
call denite#custom#map('insert', '<C-b>', '<denite:move_caret_to_left>')
call denite#custom#map('insert', '<C-a>', '<denite:move_caret_to_head>')
call denite#custom#map('insert', '<C-e>', '<denite:move_caret_to_tail>')

nnoremap <silent> <Leader>b :<C-u>Denite buffer<CR>
nnoremap <silent> <Leader>E :<C-u>Denite file/rec<CR>
nnoremap <silent> <Leader>f :<C-u>Denite `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'`<CR>
nnoremap <silent> <Leader>F :<C-u>Denite `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'` -input=`expand('%:t') != '' ? substitute(expand('%:p:h'), '^' . getcwd() . '/', '', '') : ''`<CR>
nnoremap <silent> <Leader>r :<C-u>Denite -resume<CR>
nnoremap <silent> <Leader>y :<C-u>Denite neoyank<CR>
nnoremap <silent> <Leader>* :<C-u>Denite line -input=<C-r><C-w><CR>
nnoremap <silent> <Leader>g :<C-u>Denite grep<CR>
nnoremap <silent> <Leader>G :<C-u>DeniteCursorWord grep -input=<C-r><C-w><CR><CR>

nnoremap <silent> >> :<C-u>Denite -resume -immediately -select=+1<CR>
nnoremap <silent> << :<C-u>Denite -resume -immediately -select=-1<CR>

" Rails
nnoremap <silent> <Leader>A :<C-u>Denite file/rec/git -input=app/assets/<CR>
nnoremap <silent> <Leader>C :<C-u>Denite file/rec/git -input=app/controllers/<CR>
nnoremap <silent> <Leader>D :<C-u>Denite file/rec/git -input=db/<CR>
nnoremap <silent> <Leader>H :<C-u>Denite file/rec/git -input=app/helpers/<CR>
nnoremap <silent> <Leader>M :<C-u>Denite file/rec/git -input=app/models/<CR>
nnoremap <silent> <Leader>S :<C-u>Denite file/rec/git -input=app/serializer/<CR>
nnoremap <silent> <Leader>T :<C-u>Denite file/rec/git -input=spec/<CR>
nnoremap <silent> <Leader>V :<C-u>Denite file/rec/git -input=app/views/<CR>
