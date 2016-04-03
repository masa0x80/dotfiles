" colorscheme
if dein#tap('vim-colors-solarized')
  set background=dark
  colorscheme solarized
endif

let g:lightline = {
  \   'colorscheme': g:colors_name,
  \   'mode_map': {'c': 'NORMAL'},
  \   'active': {
  \     'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
  \   },
  \   'component_function': {
  \     'modified':     'MyModified',
  \     'readonly':     'MyReadonly',
  \     'fugitive':     'MyFugitive',
  \     'filename':     'MyFilename',
  \     'fileformat':   'MyFileformat',
  \     'filetype':     'MyFiletype',
  \     'fileencoding': 'MyFileencoding',
  \     'mode':         'MyMode',
  \   },
  \ }
function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
       \  &ft == 'unite' ? unite#get_status_string() :
       \  &ft == 'vimshell' ? vimshell#get_status_string() :
       \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != MyModified() ? ' ' . MyModified() : '')
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
let g:unite_force_overwrite_statusline = 0
