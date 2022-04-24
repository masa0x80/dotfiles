if globpath(&runtimepath, '') !~# 'columnskip'
  finish
endif

" non-blank mappings
nmap sj <Plug>(columnskip:nonblank:next)
omap sj <Plug>(columnskip:nonblank:next)
xmap sj <Plug>(columnskip:nonblank:next)
nmap sk <Plug>(columnskip:nonblank:prev)
omap sk <Plug>(columnskip:nonblank:prev)
xmap sk <Plug>(columnskip:nonblank:prev)

" first non-blank mappings
nmap s] <Plug>(columnskip:first-nonblank:next)
omap s] <Plug>(columnskip:first-nonblank:next)
xmap s] <Plug>(columnskip:first-nonblank:next)
nmap s[ <Plug>(columnskip:first-nonblank:prev)
omap s[ <Plug>(columnskip:first-nonblank:prev)
xmap s[ <Plug>(columnskip:first-nonblank:prev)
