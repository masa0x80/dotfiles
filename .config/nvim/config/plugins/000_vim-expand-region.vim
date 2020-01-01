if globpath(&runtimepath, '') !~# 'vim-expand-region'
  finish
endif

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" NOTE: Configuration for vim-expand-region
"       il (inside line)   --- Available through https://github.com/kana/vim-textobj-line
"       im (inner method)  --- Available through https://github.com/vim-ruby/vim-ruby
"       am (around method) --- Available through https://github.com/vim-ruby/vim-ruby
let g:expand_region_text_objects_ruby = {
  \   'iw'  :0,
  \   'iW'  :0,
  \   'i"'  :0,
  \   'i''' :0,
  \   'i]'  :1,
  \   'ib'  :1,
  \   'iB'  :1,
  \   'il'  :0,
  \   'ip'  :0,
  \   'im'  :0,
  \   'am'  :0,
  \ }
