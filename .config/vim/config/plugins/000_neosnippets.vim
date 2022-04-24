if globpath(&runtimepath, '') !~# '\/neosnippet\.vim'
  finish
endif

let g:neosnippet#enable_conceal_markers = 0

" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
