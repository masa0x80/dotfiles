augroup HighlightSpaces
  autocmd!
  autocmd CursorMoved * match Spaces /　\|[　 ]\+$/
augroup END

set background=dark
colorscheme hybrid
highlight IndentGuidesEven guibg=White ctermbg=White
highlight Spaces guibg=DarkGrey ctermbg=DarkGrey
highlight CursorLine ctermfg=LightBlue
highlight Search cterm=underline ctermfg=DarkGreen ctermbg=0 gui=underline guifg=#bec879 guibg=Black

source ~/.config/nvim/userautoload/plugins/config/lightline.vim
