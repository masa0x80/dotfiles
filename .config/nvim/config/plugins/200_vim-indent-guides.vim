if globpath(&runtimepath, '') !~# 'vim-indent-guides'
  finish
endif

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 1

autocmd MyAutoCmd ColorScheme *
  \ highlight IndentGuidesOdd ctermfg=darkgrey
autocmd MyAutoCmd ColorScheme *
  \ highlight IndentGuidesEven ctermfg=grey ctermbg=darkgrey
