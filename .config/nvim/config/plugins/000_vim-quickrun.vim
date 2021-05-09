if globpath(&runtimepath, '') !~# 'vim-quickrun'
  finish
endif

let g:quickrun_no_default_key_mappings = 1
let g:quickrun_config = {
  \   '_': {
  \     'outputter': 'buffer',
  \     'outputter/buffer/split': 'below 15',
  \     'runner': 'vimproc'
  \   }
  \ }

if has('nvim')
  let g:quickrun_config._.runner = 'neovim_job'
elseif exists('*ch_close_in')
  let g:quickrun_config._.runner = 'job'
endif

let g:quickrun_config['rspec'] = {
  \   'command': 'rspec',
  \   'cmdopt': '-f p',
  \   'exec': 'bundle exec %c %o %s',
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
autocmd MyAutoCmd BufWinEnter,BufNewFile *_spec.rb call <SID>RSpecQuickrun()

nnoremap <silent> <Leader>x :!echo wating...<CR>:QuickRun<CR>
nnoremap <silent> <Leader>t :execute 'QuickRun rspec.line -args ' . line('.')<CR>
