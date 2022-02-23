if globpath(&runtimepath, '') !~# 'vim-quickrun'
  finish
endif

let g:quickrun_no_default_key_mappings = 1
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
  \ 'outputter/buffer/opener': '5new',
  \ 'outputter/buffer/into': 0,
  \ 'outputter/buffer/close_on_empty': 1,
  \ }

if has('nvim')
  let g:quickrun_config._.runner = 'neovim_job'
elseif exists('*ch_close_in')
  let g:quickrun_config._.runner = 'job'
endif

let g:quickrun_config.rspec = {
  \   'command': 'rspec',
  \   'cmdopt': '-f p',
  \   'exec': 'bundle exec %c %o %s',
  \   'filetype': 'rspec-result'
  \ }
let g:quickrun_config.rspec_line = {
  \   'command': 'rspec',
  \   'exec': 'bundle exec %c %s:%a',
  \   'filetype': 'rspec-result'
  \ }
let g:quickrun_config.plantuml = {
  \   'exec': 'MarkdownPreview',
  \   'runner': 'vimscript'
  \ }
let g:quickrun_config.typescript = {
  \   'command': 'node'
  \ }

function! s:RSpecQuickrun()
  let b:quickrun_config = { 'type': 'rspec' }
endfunction
autocmd MyAutoCmd BufWinEnter,BufNewFile *_spec.rb call <SID>RSpecQuickrun()

nnoremap <silent> <Leader>x :!echo wating...<CR>:QuickRun<CR>
nnoremap <silent> <Leader>X :execute 'QuickRun rspec_line -args ' . line('.')<CR>
