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

nmap mm <Plug>(easymotion-overwin-line)
nmap MM <Plug>(easymotion-overwin-w)
nmap s <Plug>(easymotion-overwin-f2)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
