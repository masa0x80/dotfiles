" NeoSnippet
"" Plugin key-mappings.
imap <C-j> <Plug>(neosnippet_expand_or_jump)
smap <C-j> <Plug>(neosnippet_expand_or_jump)
xmap <C-j> <Plug>(neosnippet_expand_target)

"" SuperTab like snippets behavior.
imap <expr><C-k> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)"
  \ : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><C-k> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)"
  \ : "\<TAB>"

"" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
