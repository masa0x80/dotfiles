" Jump to head or tail
nnoremap 1 ^
nnoremap 9 $

" Emacs keybindings for insert mode
imap <C-p> <Up>
imap <C-n> <Down>
imap <C-b> <Left>
imap <C-f> <Right>
imap <C-a> <Home>
imap <C-e> <End>
imap <C-d> <Del>

" ref. http://itchyny.hatenablog.com/entry/2016/02/02/210000
noremap <expr> <C-b> max([winheight(0) - 2, 1]) . "\<C-u>" . (line('.') < 1         + winheight(0) ? 'H' : 'L')
noremap <expr> <C-f> max([winheight(0) - 2, 1]) . "\<C-d>" . (line('.') > line('$') - winheight(0) ? 'L' : 'H')

" Visual mode
vnoremap > >gv
vnoremap < <gv

" Reload vimrc
nnoremap <Leader>R :<C-u>source $MYVIMRC<CR>
"
nnoremap <silent> <Esc><Esc> :<C-u>set nopaste<CR>:<C-u>nohlsearch<CR>:<C-u>cclose<CR>

" Toggle relativenumber
nnoremap <Leader>N :<C-u>setlocal relativenumber!<CR>

" Unnamed register
nnoremap x "_x
