""" easymotion
" Disable default mappings
let g:EasyMotion_do_mapping = 0

" Jump to first match with enter & space
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1

" Show target key with upper case to improve readability
let g:EasyMotion_keys = 'HKYUOPNMQWERTZXCVBASDGJF'
let g:EasyMotion_use_upper = 1

let g:EasyMotion_smartcase = 1

nmap <Leader>w <Plug>(easymotion-overwin-w)
nmap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)
nmap <Leader>l <Plug>(easymotion-overwin-line)
nmap s <Plug>(easymotion-overwin-f2)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
