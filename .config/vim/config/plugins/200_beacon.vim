if globpath(&runtimepath, '') !~# 'beacon'
  finish
endif

let g:beacon_size = 80
let g:beacon_shrink = 0
let g:beacon_fade = 1
let g:beacon_minimal_jump = 3
let g:beacon_timeout = 128

nmap n n:Beacon<CR>
nmap N N:Beacon<CR>
nmap * *:Beacon<CR>
nmap # #:Beacon<CR>

autocmd MyAutoCmd ColorScheme * highlight Beacon ctermbg=darkgrey
