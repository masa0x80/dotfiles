if globpath(&runtimepath, '') !~# 'beacon'
  finish
endif

let g:beacon_size = 32

nmap n n:Beacon<CR>
nmap N N:Beacon<CR>
nmap * *:Beacon<CR>
nmap # #:Beacon<CR>

autocmd MyAutoCmd ColorScheme * highlight Beacon ctermbg=darkgrey
