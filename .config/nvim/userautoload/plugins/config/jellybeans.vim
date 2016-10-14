let g:jellybeans_overrides = {
\    'Todo': { 'guifg': '303030', 'guibg': 'f0f000',
\              'ctermfg': 'Black', 'ctermbg': 'Yellow',
\              'attr': 'bold' },
\    'Folded': { 'guifg': 'ffffff', 'guibg': '303030',
\                'ctermfg': 'White', 'ctermbg': 'Black' }
\}
augroup HighlightSpaces
  autocmd!
  autocmd ColorScheme * highlight Spaces term=underline guibg=white ctermbg=white
  autocmd VimEnter,ColorScheme * highlight IndentGuidesEven guibg=black ctermbg=black
  autocmd VimEnter,WinEnter,BufRead * match Spaces /　\|[　 ]\+$/
augroup END
colorscheme jellybeans
highlight Spaces term=underline guibg=white ctermbg=white
