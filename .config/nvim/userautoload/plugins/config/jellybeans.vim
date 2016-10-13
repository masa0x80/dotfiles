augroup HighlightSpaces
  autocmd!
  autocmd ColorScheme * highlight Spaces term=underline guibg=white ctermbg=white
  autocmd VimEnter,ColorScheme * highlight IndentGuidesEven guibg=black ctermbg=black
  autocmd VimEnter,WinEnter,BufRead * match Spaces /　\|[　 ]\+$/
augroup END
colorscheme jellybeans
highlight Spaces term=underline guibg=white ctermbg=white
