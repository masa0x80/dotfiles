nnoremap <silent> <Leader>b :<C-u>Denite -mode=normal buffer<CR>
nnoremap <silent> <Leader>E :<C-u>Denite -mode=normal file_mru<CR>
nnoremap <silent> <Leader>f :<C-u>Denite file_rec<CR>
nnoremap <silent> <Leader>F :<C-u>Denite -input=`fnamemodify(expand('%:p'), ':~:.') != fnamemodify(getcwd(), ':~:p') ? fnamemodify(expand('%:p:h'), ':~:.') . '/' : ''` file_rec<CR>
nnoremap <silent> <Leader>j :<C-u>Denite line<CR>
nnoremap <silent> <Leader>r :<C-u>Denite -resume<CR>

" grep
nnoremap <silent> <Leader>g :<C-u>Denite grep:.<CR>
nnoremap <silent> <leader>G :<C-u>Denite -mode=normal grep:. -input=<C-r><C-w><CR><CR>

" Rails
nnoremap <silent> <Leader>C :<C-u>Denite -path=`getcwd()`/app/controllers        file_rec<CR>
nnoremap <silent> <Leader>D :<C-u>Denite -path=`getcwd()`/db                     file_rec<CR>
nnoremap <silent> <Leader>H :<C-u>Denite -path=`getcwd()`/app/helpers            file_rec<CR>
nnoremap <silent> <Leader>I :<C-u>Denite -path=`getcwd()`/config/initializers    file_rec<CR>
nnoremap <silent> <Leader>J :<C-u>Denite -path=`getcwd()`/app/assets/javascripts file_rec<CR>
nnoremap <silent> <Leader>M :<C-u>Denite -path=`getcwd()`/app/models             file_rec<CR>
nnoremap <silent> <Leader>S :<C-u>Denite -path=`getcwd()`/app/assets/stylesheets file_rec<CR>
nnoremap <silent> <Leader>T :<C-u>Denite -path=`getcwd()`/spec                   file_rec<CR>
nnoremap <silent> <Leader>V :<C-u>Denite -path=`getcwd()`/app/views              file_rec<CR>
