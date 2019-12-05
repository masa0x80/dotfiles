let g:quickrun_config = {
  \   '_': {
  \     'outputter': 'buffer',
  \     'outputter/buffer/append': 1,
  \     'outputter/buffer/split': 'below 15',
  \     'runner': 'vimproc'
  \   }
  \ }

let g:quickrun_config['rspec'] = {
  \   'command': 'rspec',
  \   'exec': 'bundle exec %c %s',
  \   'filetype': 'rspec-result'
  \ }
let g:quickrun_config['rspec.line'] = {
  \   'command': 'rspec',
  \   'exec': 'bundle exec %c %s:%a',
  \   'filetype': 'rspec-result'
  \ }

function! s:RSpecQuickrun()
  let b:quickrun_config = { 'type': 'rspec' }
endfunction

augroup RSpecConfig
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb call <SID>RSpecQuickrun()
augroup END

nnoremap <silent> <Leader>x :!echo wating...<CR>:QuickRun<CR>
nnoremap <silent> <Leader>t :execute 'QuickRun rspec.line -args ' . line('.')<CR>
