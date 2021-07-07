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
if exists('g:neovide')
  nnoremap <C-s>j <C-w>j
  nnoremap <C-s><C-j> <C-w>j
  tnoremap <C-s>j <C-\><C-n><C-w>j
  tnoremap <C-s><C-j> <C-\><C-n><C-w>j
  nnoremap <C-s>k <C-w>k
  nnoremap <C-s><C-k> <C-w>k
  tnoremap <C-s>k <C-\><C-n><C-w>k
  tnoremap <C-s><C-k> <C-\><C-n><C-w>k
  nnoremap <C-s>l <C-w>l
  nnoremap <C-s><C-l> <C-w>l
  tnoremap <C-s>l <C-\><C-n><C-w>l
  tnoremap <C-s><C-l> <C-\><C-n><C-w>l
  nnoremap <C-s>h <C-w>h
  nnoremap <C-s><C-h> <C-w>h
  tnoremap <C-s>h <C-\><C-n><C-w>h
  tnoremap <C-s><C-h> <C-\><C-n><C-w>h
  tnoremap <C-s><C-s> <C-\><C-n><C-w>W

  nnoremap <C-s><C-s> <C-w>W
else
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
endif
