if globpath(&runtimepath, '') !~# 'denite'
  finish
endif

call denite#custom#option('_', {
  \ 'prompt': '> ',
  \ 'cached_filter': v:true,
  \ 'cursor_shape': v:true,
  \ 'cursor_wrap': v:true,
  \ 'split': 'floating'
  \ })

" " NOTE: require 'lightline'
" if globpath(&rtp, '') !~# 'lightline'
"   " call denite#custom#option('default', 'statusline', v:false)
" endif

call denite#custom#var('file/rec', 'command', ['files'])

if executable('rg')
  call denite#custom#var('grep', 'command', ['rg', '--files', '--glob', '!.git'])
  call denite#custom#var('grep', 'command', ['rg', '--threads', '1'])
  call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--no-heading'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'separator', ['--'])
endif

nnoremap <silent> <Leader>e :<C-u>Denite file/rec -path=`expand('%:t') != '' ? substitute(expand('%:p:h'), '^' . getcwd() . '/', '', '') : ''`<CR>
nnoremap <silent> <Leader>E :<C-u>Denite file/rec<CR>
nnoremap <silent> <Leader>r :<C-u>Denite -resume<CR>
nnoremap <silent> <Leader>y :<C-u>Denite neoyank<CR>
nnoremap <silent> <Leader>* :<C-u>Denite line -input=<C-r><C-w><CR>
nnoremap <silent> <Leader>g :<C-u>Denite grep<CR>
nnoremap <silent> <Leader>G :<C-u>DeniteCursorWord grep -input=<C-r><C-w><CR><CR>

nnoremap <silent> >> :<C-u>Denite -resume -cursor-pos=+1 -immediately<CR>
nnoremap <silent> << :<C-u>Denite -resume -cursor-pos=-1 -immediately<CR>

function! s:denite_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
endfunction
autocmd MyAutoCmd FileType denite call <SID>denite_settings()
