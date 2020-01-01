" Skip initialization for vim-tiny or vim-small
if !1 | finish | endif

let g:mapleader=","

" Define the autocmd group to reset autocmd
augroup MyAutoCmd | autocmd! | augroup END

" Highlight both spaces and ideographic spaces
autocmd MyAutoCmd ColorScheme * match Visual /[　 ]\+$/

" Save cursor position
autocmd MyAutoCmd BufRead *
  \  if &filetype != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$")
  \|   execute "normal g`\""
  \| endif

" Load config files
call map(sort(split(globpath(&runtimepath, 'config/**/*.vim'))), { ->[execute('exec "source" v:val')] })

" Load a local config file
if filereadable(findfile('$HOME/.config.local/nvim/common.vim'))
  source $HOME/.config.local/nvim/common.vim
endif
