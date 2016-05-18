""" easymotion
" Disable default mappings
let g:EasyMotion_do_mapping = 0

" Jump to first match with enter & space
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1

" Show target key with upper case to improve readability
let g:EasyMotion_keys = ';HKLYUIOPNM,QWERTZXCVBASDGJF'
let g:EasyMotion_use_upper = 1

let g:EasyMotion_smartcase = 1

map f <Plug>(easymotion-s2)

hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment

hi link EasyMotionTarget2First MatchParen
hi link EasyMotionTarget2Second MatchParen

hi link EasyMotionMoveHL Search


""" incsearch
let g:incsearch#auto_nohlsearch = 1

" You can use other keymappings like <C-l> instead of <CR> if you want to
" use these mappings as default search and somtimes want to move cursor with
" EasyMotion.
function! s:incsearch_config(...) abort
  return incsearch#util#deepextend(deepcopy({
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {
  \     "\<CR>": '<Over>(easymotion)'
  \   },
  \   'is_expr': 0
  \ }), get(a:, 1, {}))
endfunction

map <silent><expr> /  incsearch#go(<SID>incsearch_config())
map <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
map <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))

map n <Plug>(incsearch-nohl-n)
map N <Plug>(incsearch-nohl-N)
