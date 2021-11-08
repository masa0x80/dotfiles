if !has('nvim')
  finish
endif

autocmd MyAutoCmd TermOpen * startinsert
autocmd MyAutoCmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif

" Open Terminal
nnoremap <D-t> :<C-u>split<CR>:<C-u>wincmd j<CR>:<C-u>resize 15<CR>:<C-u>terminal<CR>

" Esc
tnoremap <Esc> <C-\><C-n>

" Window
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w><C-j> <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w><C-k> <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l
tnoremap <C-w><C-l> <C-\><C-n><C-w>l
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w><C-h> <C-\><C-n><C-w>h
tnoremap <C-w>w <C-\><C-n><C-w>w
tnoremap <C-w><C-w> <C-\><C-n><C-w>w
tnoremap <C-w>w <C-\><C-n><C-w>W
tnoremap <C-w><C-w> <C-\><C-n><C-w>W

tnoremap <C-w><C-w> <C-w>
