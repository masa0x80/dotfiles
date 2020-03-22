" Esc
nnoremap <C-c> <Esc>

" Save
nnoremap s <NOP>
nnoremap ss :<C-u>write<CR>

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

" Window
nnoremap ,- <C-w>s
nnoremap ,\| <C-w>v
nnoremap ,j <C-w>j
nnoremap ,k <C-w>k
nnoremap ,l <C-w>l
nnoremap ,h <C-w>h
nnoremap ,J <C-w>J
nnoremap ,K <C-w>K
nnoremap ,L <C-w>L
nnoremap ,H <C-w>H
nnoremap ,, <C-w><C-w>
nnoremap ,= <C-w>=
nnoremap ,o :<C-u>only<CR>

" Tab
nnoremap ,t :<C-u>tabedit<CR>

" Quit
nnoremap ,q :<C-u>q<CR>
nnoremap ,Q :<C-u>bd<CR>

" ref. http://itchyny.hatenablog.com/entry/2016/02/02/210000
noremap <expr> <C-b> max([winheight(0) - 2, 1]) . "\<C-u>" . (line('.') < 1         + winheight(0) ? 'H' : 'L')
noremap <expr> <C-f> max([winheight(0) - 2, 1]) . "\<C-d>" . (line('.') > line('$') - winheight(0) ? 'L' : 'H')

" Reload vimrc
nnoremap <Leader>R :<C-u>source $MYVIMRC<CR>

nnoremap <silent> <Esc><Esc> :<C-u>set nopaste<CR>:<C-u>nohlsearch<CR>:<C-u>cclose<CR>:<C-u>lclose<CR>

" Toggle relativenumber
nnoremap <Leader>N :<C-u>setlocal relativenumber!<CR>

" Unnamed register
nnoremap x "_x
