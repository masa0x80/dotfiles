if globpath(&runtimepath, '') !~# 'columnskip'
  finish
endif

" non-blank mappings
nmap <C-g><C-j> <Plug>(columnskip:nonblank:next)
omap <C-g><C-j> <Plug>(columnskip:nonblank:next)
xmap <C-g><C-j> <Plug>(columnskip:nonblank:next)
nmap <C-g><C-k> <Plug>(columnskip:nonblank:prev)
omap <C-g><C-k> <Plug>(columnskip:nonblank:prev)
xmap <C-g><C-k> <Plug>(columnskip:nonblank:prev)
nmap sj <Plug>(columnskip:nonblank:next)
omap sj <Plug>(columnskip:nonblank:next)
xmap sj <Plug>(columnskip:nonblank:next)
nmap sk <Plug>(columnskip:nonblank:prev)
omap sk <Plug>(columnskip:nonblank:prev)
xmap sk <Plug>(columnskip:nonblank:prev)

" first non-blank mappings
nmap <C-g><C-]> <Plug>(columnskip:first-nonblank:next)
omap <C-g><C-]> <Plug>(columnskip:first-nonblank:next)
xmap <C-g><C-]> <Plug>(columnskip:first-nonblank:next)
nmap <C-g><C-[> <Plug>(columnskip:first-nonblank:prev)
omap <C-g><C-[> <Plug>(columnskip:first-nonblank:prev)
xmap <C-g><C-[> <Plug>(columnskip:first-nonblank:prev)
nmap s] <Plug>(columnskip:first-nonblank:next)
omap s] <Plug>(columnskip:first-nonblank:next)
xmap s] <Plug>(columnskip:first-nonblank:next)
nmap s[ <Plug>(columnskip:first-nonblank:prev)
omap s[ <Plug>(columnskip:first-nonblank:prev)
xmap s[ <Plug>(columnskip:first-nonblank:prev)
