" Esc
nnoremap <C-c> <Esc>
inoremap <C-c> <Esc>

" Disable EX-mode (if you switch EX-mode, push gQ)
nnoremap Q <NOP>

" Save
nnoremap ; <NOP>
nnoremap ;; :<C-u>write<CR>

" Jump to head or tail
nnoremap <C-p> ^
nnoremap <C-n> $

" Emacs keybindings for insert mode
imap <C-p> <Up>
imap <C-n> <Down>
imap <C-b> <Left>
imap <C-f> <Right>
imap <C-a> <Esc>I
imap <C-e> <Esc>A
imap <C-d> <Del>
imap <C-g><C-h> <Esc>bi
imap <C-g><C-l> <Esc>ea

nnoremap <C-j> }
vnoremap <C-j> }
nnoremap <C-k> {
vnoremap <C-k> {

nmap <buffer> <C-g><C-j> ]M
nmap <buffer> <C-g><C-k> [m
vmap <buffer> <C-g><C-j> ]M
vmap <buffer> <C-g><C-k> [m

" Window
nnoremap ,, <C-w>w
nnoremap ,< <C-w>W
nnoremap <C-w>- <C-w>s
nnoremap <C-w>\| <C-w>v
nnoremap <C-w>o <NOP>
nnoremap <C-w>O :<C-u>only<CR>

" Tab
nnoremap ,t :<C-u>tabedit %:p<CR>
nnoremap <C-t><C-n> :<C-u>tabnext<CR>
nnoremap <C-t><C-p> :<C-u>tabprevious<CR>
nnoremap <C-t>N :<C-u>tabmove +<CR>
nnoremap <C-t>P :<C-u>tabmove -<CR>

" Tags
nnoremap <silent> <C-t><C-t> :<C-u>pop<CR>
nnoremap <silent> <C-h> :<C-u>pop<CR>

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

" Replace
nnoremap <Leader>re :%s;\<<C-R><C-W>\>;g<Left><Left>;
vnoremap <Leader>re :s;;g<Left><Left><Left>;

" Toggle relativenumber
nnoremap <Leader>N :<C-u>setlocal relativenumber!<CR>

" Unnamed register
nnoremap x "_x
