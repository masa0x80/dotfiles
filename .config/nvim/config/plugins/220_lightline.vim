if globpath(&runtimepath, '') !~# 'lightline\.vim'
  finish
endif

let g:lightline = {
  \   'active': {
  \     'left': [
  \       ['mode', 'paste'],
  \       ['filename', 'readonly', 'modified']
  \     ],
  \   },
  \   'inactive': {
  \     'left': [
  \       ['relativepath']
  \     ]
  \   },
  \   'component_function': {
  \     'modified':     'LightlineModified',
  \     'readonly':     'LightlineReadonly',
  \     'filename':     'LightlineFilename',
  \     'filetype':     'LightlineFiletype',
  \     'fileformat':   'LightlineFileformat',
  \     'fileencoding': 'LightlineFileEncoding',
  \     'mode':         'LightlineMode'
  \   },
  \   'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
  \   'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
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
  return (&ft == 'fern' ? '' : '' != expand('%:t') ?
      \  (winwidth(0) > 70 ? expand('%f') : expand('%:t')) : '[No Name]')
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
