" QuickRun
nnoremap <silent> <Leader>x :!echo wating...<CR>:QuickRun<CR>
" 初期化
if !has("g:quickrun_config")
  let g:quickrun_config = {}
endif
" QuickRun 実行時のバッファの開き方
let g:quickrun_config._ = {
  \   'outputter' : 'buffer',
  \   'split' : 'rightbelow 10sp',
  \   '_': {
  \     'runner' : 'vimproc'
  \   },
  \ }

" rspec
let g:quickrun_config['ruby.rspec'] = {
  \   'command': 'rspec',
  \ }
let g:quickrun_config.rspecl = {
  \   'type': 'rspec',
  \   'exec': 'bundle exec %c %s:' . line('.'),
  \ }
augroup RSpecQuickrun
  autocmd!
  autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END
nnoremap <silent> <Leader>s :<C-u>QuickRun rspecl<CR>
