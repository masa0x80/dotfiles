" {{{ ref. https://github.com/dag/vim-fish
" Set up :make to use fish for syntax checking.
compiler fish

set softtabstop=4 tabstop=4 shiftwidth=4

" Set this to have long lines wrap inside comments.
setlocal textwidth=79
" }}}

" {{{ ALE config
let b:ale_fixers = ['fish_indent']
"}}}
