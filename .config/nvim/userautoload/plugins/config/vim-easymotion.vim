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

nmap f <Plug>(easymotion-s)

hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment

hi link EasyMotionTarget2First MatchParen
hi link EasyMotionTarget2Second MatchParen

hi link EasyMotionMoveHL Search
