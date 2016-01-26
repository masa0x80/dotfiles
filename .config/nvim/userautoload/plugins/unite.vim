" Unite
nnoremap <silent> <Leader>r :<C-u>Unite file_mru<CR>
nnoremap <silent> <Leader>f :<C-u>Unite file<CR>
nnoremap <silent> <Leader>F :<C-u>UniteWithBufferDir file<CR>
nnoremap <silent> <Leader>b :<C-u>Unite buffer<CR>

augroup vimrc
  autocmd!
  autocmd FileType unite nnoremap <silent> <buffer> <ESC> :q<CR>
  autocmd FileType unite inoremap <silent> <buffer> <ESC> <ESC>:q<CR>
augroup END

" grep系
nnoremap <silent> <Leader>g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
endif
