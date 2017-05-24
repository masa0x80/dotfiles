augroup HighlightSpaces
  autocmd!
  autocmd CursorMoved * match Spaces /　\|[　 ]\+$/
augroup END

let g:hybrid_reduced_contrast = 1
let g:hybrid_custom_term_colors = 1
set background=dark
colorscheme hybrid
highlight IndentGuidesEven guibg=White ctermbg=White
highlight Spaces guibg=DarkGrey ctermbg=DarkGrey
highlight CursorLine ctermfg=LightBlue

source ~/.config/nvim/userautoload/plugins/config/lightline.vim
