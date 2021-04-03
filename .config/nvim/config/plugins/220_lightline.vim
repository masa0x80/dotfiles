if globpath(&runtimepath, '') !~# 'lightline\.vim'
  finish
endif

let g:lightline = {
  \   'mode_map': {
  \     'n' : 'N',
  \     'i' : 'I',
  \     'R' : 'R',
  \     'v' : 'V',
  \     'V' : 'V-LINE',
  \     "\<C-v>": 'V-BLOCK',
  \     'c' : 'C',
  \     's' : 'S',
  \     'S' : 'S-LINE',
  \     "\<C-s>": 'S-BLOCK',
  \     't': 'T',
  \   },
  \   'active': {
  \     'left': [
  \       ['mode', 'paste'],
  \       ['filename', 'readonly', 'modified'],
  \     ],
  \   },
  \   'inactive': {
  \     'left': [
  \       ['relativepath'],
  \     ]
  \   },
  \   'component_function': {
  \     'modified':     'LightlineModified',
  \     'readonly':     'LightlineReadonly',
  \     'filename':     'LightlineFilename',
  \     'filetype':     'LightlineFiletype',
  \     'fileformat':   'LightlineFileformat',
  \     'fileencoding': 'LightlineFileEncoding',
  \     'mode':         'LightlineMode',
  \   },
  \   'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
  \   'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
  \ }

if globpath(&runtimepath, '') =~# 'iceberg'
  let g:lightline.colorscheme = 'iceberg'
endif

function! LightlineModified()
  return &ft =~ 'help\|fern' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|fern' && &readonly ? 'RO' : ''
endfunction

function! LightlineFilename()
  if &ft == 'fern'
    let relative_path = split(substitute(expand('%f'), getcwd() .. '/', '', ''), '://')[2][0:-2]
    return relative_path
  else
    return '' != expand('%:t') ? (winwidth(0) > 70 ? expand('%f') : expand('%:t')) : '[No Name]'
  endif
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileEncoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return &ft == 'fern' ? 'Fern' :
      \  winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! s:lightline_update()
  let g:lightline.colorscheme =
    \ substitute(substitute(g:colors_name, '-', '_', 'g'), '256.*', '', '')
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction
autocmd MyAutoCmd ColorScheme * call <SID>lightline_update()
