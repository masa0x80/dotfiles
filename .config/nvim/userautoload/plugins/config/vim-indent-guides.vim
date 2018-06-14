" vim-indent-guidesの設定
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_auto_colors = 1
let g:indent_guides_guide_size  = 1
let g:indent_guides_start_level = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=darkcyan ctermbg=95
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=brown ctermbg=23
