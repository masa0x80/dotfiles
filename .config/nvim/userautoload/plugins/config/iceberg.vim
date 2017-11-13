augroup HighlightSpaces
  autocmd!
  autocmd CursorMoved * match Visual /　\|[　 ]\+$/
augroup END

set background=dark
colorscheme iceberg

source ~/.config/nvim/userautoload/plugins/config/lightline.vim
