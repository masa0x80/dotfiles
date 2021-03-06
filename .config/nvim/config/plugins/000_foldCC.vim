if globpath(&runtimepath, '') !~# 'foldCC'
  finish
endif

set foldtext=FoldCCtext()
let g:foldCCtext_enable_autofdc_adjuster = 1
let g:foldCCtext_tail = 'v:foldend-v:foldstart+1'

nnoremap <expr>l foldclosed('.') != -1 ? 'zo' : 'l'
nnoremap <silent><leader>z :<C-u>call <SID>smart_foldcloser()<CR>
function! s:smart_foldcloser() "{{{
  if foldlevel('.') == 0
    norm! zM
    return
  endif

  let foldc_lnum = foldclosed('.')
  norm! zc
  if foldc_lnum == -1
    return
  endif

  if foldclosed('.') != foldc_lnum
    return
  endif
  norm! zM
endfunction
"}}}

nnoremap z[ :<C-u>call <SID>put_foldmarker(0)<CR>
nnoremap z] :<C-u>call <SID>put_foldmarker(1)<CR>zc
function! s:put_foldmarker(foldclose_p) "{{{
  let crrstr = getline('.')
  let padding = crrstr=='' ? '' : crrstr=~'\s$' ? '' : ' '
  let [cms_start, cms_end] = ['', '']
  let outside_a_comment_p = synIDattr(synID(line('.'), col('$')-1, 1), 'name') !~? 'comment'
  if outside_a_comment_p
    let cms_start = matchstr(&cms,'\V\s\*\zs\.\+\ze%s')
    let cms_end = matchstr(&cms,'\V%s\zs\.\+')
  endif
  let fmr = split(&fmr, ',')[a:foldclose_p]. (v:count ? v:count : '')
  exe 'norm! A'. padding. cms_start. fmr. cms_end
endfunction
"}}}

noremap  <silent>z_ zMzvzc
nnoremap <silent>z0 :<C-u>set foldlevel=<C-r>=foldlevel('.')<CR><CR>
