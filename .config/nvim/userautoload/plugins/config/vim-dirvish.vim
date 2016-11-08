augroup DirvishConfig
  autocmd!

  " Enable :Gstatus and friends.
  autocmd FileType dirvish call fugitive#detect(@%)

  " Map CTRL-R to reload the Dirvish buffer.
  autocmd FileType dirvish nnoremap <buffer> <C-r> :<C-u>Dirvish %<CR>

  " Map `gh` to hide dot-prefixed files.
  " To "toggle" this, just press `R` to reload.
  autocmd FileType dirvish nnoremap <buffer>
    \ gh :keeppatterns g@\v/\.[^\/]+/?$@d<CR>
augroup END

map <Leader>F -
nnoremap <Leader>e :edit %

nnoremap <Leader>C :edit app/controllers<CR>
nnoremap <Leader>D :edit db<CR>
nnoremap <Leader>H :edit app/helpers<CR>
nnoremap <Leader>I :edit config/initializers<CR>
nnoremap <Leader>J :edit app/assets/javascripts<CR>
nnoremap <Leader>M :edit app/models<CR>
nnoremap <Leader>S :edit app/assets//stylesheets<CR>
nnoremap <Leader>T :edit spec<CR>
nnoremap <Leader>V :edit app/views<CR>
