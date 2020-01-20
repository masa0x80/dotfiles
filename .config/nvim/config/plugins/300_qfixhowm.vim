if globpath(&runtimepath, '') !~# 'qfixhowm'
  finish
endif

let g:qfixmemo_title = '#'
let g:QFixHowm_UserFileType = 'markdown'
let s:suffix = 'md'
let QFixHowm_UserFileExt = s:suffix
let g:howm_filename = '%Y/%m/%Y-%m-%dT%H%M%S.' . s:suffix

let g:QFixWin_EnableMode = 1
let g:QFixHowm_SaveTime = -1
let g:QFixHowm_Template = [
  \   '# %TAG%',
  \   ''
  \ ]

if executable('rg')
  let g:mygrepprg               = 'rg'
  let g:MyGrepcmd_useropt       = '-nH --no-heading --color never'
  let g:MyGrepcmd_regexp        = ''
  let g:MyGrepcmd_regexp_ignore = '-i'
  let g:MyGrepcmd_fix           = '-F'
  let g:MyGrepcmd_fix_ignore    = '-F -i'
  let g:MyGrepcmd_recursive     = ''
  let g:MyGrep_GrepFilePattern  = '.'
endif
