if !exists('g:neovide')
  finish
endif

let g:neovide_fullscreen      = v:false
let g:neovide_refresh_rate    = 140
let g:neovide_transparency    = 0.8
let g:neovide_cursor_vfx_mode = 'pixiedust'

" system clipboard
nmap <D-c> "+y
vmap <D-c> "+y
nmap <D-v> "+p
inoremap <D-v> <C-r>+
cnoremap <D-v> <C-r>+
" use <c-r> to insert original character without triggering things like auto-pairs
inoremap <D-r> <C-v>
