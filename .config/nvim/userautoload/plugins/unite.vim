" Unite
nnoremap <silent> <Leader>r :<C-u>Unite file_mru<CR>
nnoremap <silent> <Leader>f :<C-u>Unite file<CR>
nnoremap <silent> <Leader>F :<C-u>UniteWithBufferDir file<CR>
nnoremap <silent> <Leader>b :<C-u>Unite buffer<CR>

augroup vimrc
  autocmd!
  autocmd FileType unite nmap <buffer> <ESC> <Plug>(unite_exit)
  autocmd FileType unite imap <buffer> <ESC> <Plug>(unite_exit)
  autocmd FileType unite nmap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  autocmd FileType unite nmap <buffer> <C-u> <Plug>(unite_delete_backward_path)
  autocmd FileType unite nmap <buffer> <C-n> <Plug>(unite_loop_cursor_down)
  autocmd FileType unite nmap <buffer> <C-p> <Plug>(unite_loop_cursor_up)
  autocmd FileType unite nmap <buffer> <C-j> <Plug>(unite_do_default_action)
  autocmd FileType unite imap <buffer> <C-j> <Plug>(unite_do_default_action)
augroup END

" grep
nnoremap <silent> <Leader>g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> <leader>r :<C-u>UniteResume search-buffer<CR><Esc>
nnoremap <silent> <leader>cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-r><C-w>
if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
endif
