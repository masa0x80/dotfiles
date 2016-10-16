augroup HighlightSpaces
  autocmd!
  autocmd CursorMoved * match Spaces /　\|[　 ]\+$/
augroup END

let g:hybrid_reduced_contrast = 1
set background=dark
colorscheme hybrid
highlight IndentGuidesEven guibg=black ctermbg=black
highlight Spaces term=underline guibg=darkgrey ctermbg=darkgrey

source ~/.config/nvim/userautoload/plugins/config/lightline.vim
