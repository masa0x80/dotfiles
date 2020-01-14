if globpath(&runtimepath, '') !~# 'lightline\.vim'
  finish
endif

let g:lightline = {
  \   'mode_map': {
  \     'c': 'NORMAL'
  \   },
  \   'active': {
  \     'left': [
  \       ['mode', 'paste'],
  \       ['readonly', 'filename', 'fugitive',  'modified']
  \     ],
  \   },
  \   'inactive': {
  \     'left': [
  \       ['relativepath']
  \     ],
  \     'right': [
  \       ['syntastic', 'lineinfo'],
  \       ['percent']
  \     ]
  \   },
  \   'component_function': {
  \     'modified':     'MyModified',
  \     'readonly':     'MyReadonly',
  \     'fugitive':     'MyFugitive',
  \     'fileformat':   'MyFileformat',
  \     'fileencoding': 'MyFileencoding',
  \     'filetype':     'MyFiletype',
  \     'mode':         'MyMode'
  \   }
  \ }

if globpath(&runtimepath, '') !~# 'iceberg'
  let g:lightline.colorscheme = 'iceberg'
endif

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! s:lightline_update()
  let g:lightline.colorscheme =
    \ substitute(substitute(g:colors_name, '-', '_', 'g'), '256.*', '', '')
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction
autocmd MyAutoCmd ColorScheme * call <SID>lightline_update()
