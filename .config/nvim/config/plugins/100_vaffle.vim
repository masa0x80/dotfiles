if globpath(&runtimepath, '') !~# 'vaffle'
  finish
endif

let g:vaffle_use_default_mappings = 1
let g:vaffle_show_hidden_files = 1

function! s:customize_vaffle_mappings() abort
  nmap <buffer> <silent> <Space> <Plug>(vaffle-toggle-current)
  vmap <buffer> <silent> <Space> <Plug>(vaffle-toggle-current)
  nmap <buffer> <silent> .       <Plug>(vaffle-toggle-hidden)
  nmap <buffer> <silent> +       <Plug>(vaffle-toggle-all)

  nmap <buffer> <silent> m    <Plug>(vaffle-move-selected)
  nmap <buffer> <silent> <CR> <Plug>(vaffle-open-selected)
  nmap <buffer> <silent> r    <Plug>(vaffle-rename-selected)

  nmap <buffer> l                   <Plug>(vaffle-open-current)
  nmap <buffer> <nowait> <silent> t <Plug>(vaffle-open-current-tab)

  nmap <buffer> <silent> o <Plug>(vaffle-mkdir)
  nmap <buffer> <silent> i <Plug>(vaffle-new-file)
  nmap <buffer> <silent> ~ <Plug>(vaffle-open-home)
  nmap <buffer> <silent> h <Plug>(vaffle-open-parent)
  nmap <buffer> <silent> q <Plug>(vaffle-quit)
  nmap <buffer> <silent> R <Plug>(vaffle-refresh)

  nmap <buffer> <silent> q     <Plug>(vaffle-quit)
  nmap <buffer> <silent> <C-c> <Plug>(vaffle-quit)
endfunction

augroup MyAutoCmd VaffleConfig
  autocmd FileType vaffle call s:customize_vaffle_mappings()
augroup END

nnoremap <Leader>F :<C-u>Vaffle getcwd()<CR>
nnoremap <Leader>- :<C-u>Vaffle<CR>
