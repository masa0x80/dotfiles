augroup HighlightSpaces
  autocmd!
  autocmd CursorMoved * match Spaces /　\|[　 ]\+$/
augroup END

if dein#tap('vim-hybrid')
  let g:hybrid_reduced_contrast = 1
  set background=dark
  colorscheme hybrid
  highlight IndentGuidesEven guibg=Black ctermbg=Black
  highlight Spaces guibg=DarkGrey ctermbg=DarkGrey

  " for denite.vim
  highlight CursorLine ctermfg=LightBlue

  source ~/.config/nvim/userautoload/plugins/config/lightline.vim
endif
