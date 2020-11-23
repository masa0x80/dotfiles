" Esc
nnoremap <C-c> <Esc>
inoremap <C-c> <Esc>

" Disable EX-mode (if you switch EX-mode, push gQ)
nnoremap Q <NOP>

" Save
nnoremap ; <NOP>
nnoremap ;; :<C-u>write<CR>

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
nnoremap <C-w>- <C-w>s
nnoremap <C-w>\| <C-w>v
nnoremap <C-w>j <C-w>j
nnoremap <C-w>k <C-w>k
nnoremap <C-w>l <C-w>l
nnoremap <C-w>h <C-w>h
nnoremap <C-w>J <C-w>J
nnoremap <C-w>K <C-w>K
nnoremap <C-w>L <C-w>L
nnoremap <C-w>H <C-w>H
nnoremap <C-w>, <C-w><C-w>
nnoremap <C-w>= <C-w>=
nnoremap <C-w>O :<C-u>only<CR>

" Tab
nnoremap <C-w>o :<C-u>tabedit %:p<CR>
nnoremap <C-t>t :<C-u>tabedit %:p<CR>
nnoremap <C-t><C-n> :<C-u>tabnext<CR>
nnoremap <C-t><C-p> :<C-u>tabprevious<CR>
nnoremap <C-t><C-t> :<C-u>tabrewind<CR>
nnoremap <C-t>N :<C-u>tabmove +<CR>
nnoremap <C-t>P :<C-u>tabmove -<CR>

" Quit
nnoremap <Leader>q :<C-u>q<CR>
nnoremap ,q :<C-u>q<CR>
nnoremap <Leader>Q :<C-u>bd<CR>
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
