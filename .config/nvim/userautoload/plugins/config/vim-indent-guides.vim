" vim-indent-guidesの設定
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 1
let g:indent_guides_guide_size  = 1
autocmd Colorscheme * highlight IndentGuidesOdd ctermfg=darkgrey
autocmd Colorscheme * highlight IndentGuidesEven ctermfg=grey ctermbg=darkgrey
