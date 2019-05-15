let g:lightline = {
  \   'colorscheme': g:colors_name,
  \   'mode_map': {
  \     'c': 'NORMAL'
  \   },
  \   'active': {
  \     'left': [
  \       ['mode', 'paste'],
  \       ['fugitive', 'readonly', 'filename', 'modified']
  \     ],
  \     'right': [
  \       ['syntastic', 'lineinfo'],
  \       ['percent'],
  \       ['ctags', 'fileformat', 'fileencoding', 'filetype']
  \     ]
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
  \     'mode':         'MyMode',
  \     'ctags':        'MyCtagsStatus'
  \   }
  \ }

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
  if &ft == 'denite'
    let l:mode_name = substitute(denite#get_status_mode(), '[^A-Z]', '', 'g')
    call lightline#link(tolower(l:mode_name[0]))
    return l:mode_name
  else
    return winwidth(0) > 60 ? lightline#mode() : ''
  endif
endfunction

function! MyCtagsStatus()
  let l:status = dein#tap('vim-gutentags') == 1 ? gutentags#statusline() : ''
  return winwidth(0) > 50 ? l:status : ''
endfunction

augroup LightlineColorscheme
  autocmd!
  autocmd Colorscheme * call <SID>lightline_update()
augroup END

function! s:lightline_update()
  let g:lightline.colorscheme =
    \ substitute(substitute(g:colors_name, '-', '_', 'g'), '256.*', '', '')
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction
